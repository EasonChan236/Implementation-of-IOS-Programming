//
//  DetailViewController.swift
//  Homepwner
//
//  Created by EasonChan on 12/30/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    //@IBOutlet var nameField: UITextField!
    //@IBOutlet var serialNumberField: UITextField!
    //@IBOutlet var valueField: UITextField!
    @IBOutlet var nameField: SubTextField!
    @IBOutlet var serialNumberField: SubTextField!
    @IBOutlet var valueField: SubTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ImageView: UIImageView!
    // MARK: - funcs
    @IBAction func deletePicture(_ sender: UIBarButtonItem) {
        let title = "Delete \(item.name) Image"
        let message = "Are you sure you want to delete this image?"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            self.imageStore.deleteImageForKey(key: self.item.itemKey)
            self.ImageView.image = nil
        })
        
        ac.addAction(deleteAction)
        
        present(ac, animated: true, completion: nil)
    
    }
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        //if the device has a camera , take a picture; otherwise, just pick form photo libaray
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            
        }
        else{
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    var item: Item!{
        didSet{
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get picked image form info dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //store the image to cache
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        //put that image on the screen in the iamge veiw
        ImageView.image = image
        
        //take image picker off the screen
        // you must call this dismiss method
        dismiss(animated: true, completion:nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber )
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date )
        
        let key = item.itemKey
        //if there is a associated image with the item display it on th image view
        let imageToDisplay = imageStore.imageForKey(key: key)
        ImageView.image = imageToDisplay
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
        
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //clear first responder
        view.endEditing(true)
        
        
        //save changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        }
        else{
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  itemsViewController.swift
//  Homepwner
//
//  Created by EasonChan on 12/27/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController{
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    @IBAction func addNewItem(sender: AnyObject){
        //let lastRow = tableView.numberOfRows(inSection: 0)
        //let indexPath = NSIndexPath(row: lastRow, section:0)
        //create a nre item and add it to the store 
        let newItem = itemStore.createItem()
        
        //figure out where tha item is in the array
        if let index = itemStore.allItems.index(of: newItem){
            let indexPath = NSIndexPath(row: index, section:0)
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)

        }
    }
    /*
    @IBAction func toggleEditingMode(sender: AnyObject){
        if isEditing {
            // change text of button ot inform user of state
            sender.setTitle("Edit", for: .normal)
            //turn off editing mode
            setEditing(false, animated: true)
        }
        else{
            // change text of button ot inform user of state
            sender.setTitle("Done", for: .normal)
            //turn off editing mode
            setEditing(true, animated: true)
        }
        
    }
    */
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if the trigger segue is the "ShowItem" segue
        if segue.identifier == "ShowItem"{
            
            //figure out which row is selected
            if let row = tableView.indexPathForSelectedRow?.row{
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
                
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        //update the model
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex:destinationIndexPath.row)
    }
    //how many rows to show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int{
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //create an instance of UITableViewCell with default appearnace
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UItableViewCell")
        
        //get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //update the labes for the new preferred text size
        cell.updateLabels()
        
        
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        cell.updateValueLabelColor(value: item.valueInDollars)
        
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    //used to delete the item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        //if the table view is adsking to commit a delet ecommand
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete /(item.name)"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title:title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title:"Remove", style: .destructive, handler:{
                (action) -> Void in
                self.itemStore.removeItem(item: item)
                
                //remove the item's image from the image store
                self.imageStore.deleteImageForKey(key: item.itemKey)
                self.tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            //present the aller controller
            present(ac, animated: true, completion:nil)
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        */
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
}

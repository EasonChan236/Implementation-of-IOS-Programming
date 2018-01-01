//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by EasonChan on 12/21/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValues: Double?{
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = fahrenheitValues{
            return (value - 32)*(5/9)
        }
        else{
            return nil
        }
    }
    
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: value as NSNumber)}
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenHeitFieldEditingCHanged(textField: UITextField){
        //if let text = textField.text, let value = Double(text) {
        //    fahrenheitValues = value
        //}
        //localization
        if let text = textField.text, let number = numberFormatter.number(from: text){
            fahrenheitValues = number.doubleValue
        }
        else {
            fahrenheitValues = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    func textField( _ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String ) -> Bool {
        //let existingTextHasDecimalSeparator = textField.text?.range(of:".")
        //let replacementTextHasDecimalSeparator = string.range(of:".")
        let currentLocale = NSLocale.current
        let decimalSeparator:String = currentLocale.decimalSeparator!
        
        let existingTextHasDecimalSeparator = textField.text?.range(of:decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of:decimalSeparator)
        
        let letters = NSCharacterSet.letters
        let replacementTextHasAlphabeticCharacters = string.rangeOfCharacter(from:letters)
        
        if (existingTextHasDecimalSeparator != nil &&
            replacementTextHasDecimalSeparator != nil) ||
        replacementTextHasAlphabeticCharacters != nil {
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let currentDate = NSDate()
        let currentCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentComponents = currentCalendar?.components(.hour, from: currentDate as Date)
        let currentHour = currentComponents!.hour
        
        let backgroundUIColor = UIColor(red: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                        green: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                        blue: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                        alpha: 1.0)
        if let hour = currentHour{
            switch hour {
            case 0 ... 6, 20...23:
                view.backgroundColor = UIColor.darkGray
                break
            default:
                view.backgroundColor = backgroundUIColor
            }
        }
    }
}

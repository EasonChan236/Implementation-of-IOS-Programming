//
//  SubTextField.swift
//  Homepwner
//
//  Created by EasonChan on 12/30/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class SubTextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .line
        
        return true
        
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        self.borderStyle = .roundedRect
        
        return true
    }
}

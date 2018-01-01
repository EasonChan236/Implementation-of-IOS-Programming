//
//  ItemCell.swift
//  Homepwner
//
//  Created by EasonChan on 12/28/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell{
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels(){
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        serialNumberLabel.font = captionFont
    }
    func updateValueLabelColor(value: Int){
        if value >= 50 {
            valueLabel.textColor = UIColor.red
        } else {
            valueLabel.textColor = UIColor.green
        }
    }
}

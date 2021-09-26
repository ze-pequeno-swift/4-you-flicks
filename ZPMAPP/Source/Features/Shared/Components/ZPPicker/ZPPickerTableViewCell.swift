//
//  ZPPickerTableViewCell.swift
//  ZPMAPP
//
//  Created by Hellen on 26/09/21.
//

import UIKit

class ZPPickerTableViewCell: UITableViewCell {
    
    @IBOutlet private var label: UILabel!
    
    static var identifier = "ZPPickerTableViewCell"
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let color = selected ? UIColor.customRed : UIColor.cyan
        label.textColor = color
    }
    
    func setup(withLabel label: String) {
        self.label.text = label
    }
    
}

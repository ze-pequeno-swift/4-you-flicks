//
//  HeaderSection.swift
//  ZPMAPP
//
//  Created by Alan Silva on 19/09/21.
//

import UIKit

class HeaderSection: UITableViewCell {

    @IBOutlet weak var titleSection: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(value: String) {
        titleSection.text = value
    }
    
    static var identifier: String {
        String(describing: HeaderSection.self)
    }

}

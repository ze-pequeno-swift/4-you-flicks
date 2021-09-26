//
//  HeaderSection.swift
//  ZPMAPP
//
//  Created by Alan Silva on 19/09/21.
//

import UIKit

class HeaderSection: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleSection: UILabel!
 
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: HeaderSection.self)
    }
    
    // MARK: - Public Functions
    
    func setup(value: String) {
        titleSection.text = value
    }
}

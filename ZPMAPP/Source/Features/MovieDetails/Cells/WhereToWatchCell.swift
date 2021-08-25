//
//  WhereToWatchCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class WhereToWatchCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
    }

    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: WhereToWatchCell.self)
    }
    
}

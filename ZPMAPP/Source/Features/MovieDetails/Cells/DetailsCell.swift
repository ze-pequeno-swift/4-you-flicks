//
//  DetailsCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailsView.layer.cornerRadius = 15
        detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        posterView.layer.cornerRadius = 8
        posterView.layer.masksToBounds = true
    }

    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: DetailsCell.self)
    }
    
}

//
//  DescriptionCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class DescriptionCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private var cardView: UIView!
    
    @IBOutlet private var descriptionText: UILabel!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: DescriptionCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
    }
    
    // MARK: - Public Functions
    
    func setupCell(_ movie: Movie) {
        descriptionText.text = movie.overview
    }
}

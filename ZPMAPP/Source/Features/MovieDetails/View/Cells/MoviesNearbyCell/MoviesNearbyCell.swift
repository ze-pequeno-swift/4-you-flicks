//
//  MoviesNearbyCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class MoviesNearbyCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private var cardView: UIView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: MoviesNearbyCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
    }
    
    // MARK: - Private Functions
    
    @IBAction func openMapButton(_ sender: UIButton) {
        print("Debug: Tapped Open Map...")
    }
}

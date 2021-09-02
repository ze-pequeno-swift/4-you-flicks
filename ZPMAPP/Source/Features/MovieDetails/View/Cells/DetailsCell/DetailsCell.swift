//
//  DetailsCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var backdropImage: UIImageView!
    @IBOutlet private var detailsView: UIView!
    @IBOutlet private var posterView: UIView!
    @IBOutlet private var posterImage: UIImageView!
    @IBOutlet private var titleMovie: UILabel!
    @IBOutlet private var timeMovie: UILabel!
    @IBOutlet private var genreMovie: UILabel!
    @IBOutlet private var scoreRottenTomatoes: UILabel!
    @IBOutlet private var ScoreImbd: UILabel!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: DetailsCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private Functions

    private func setupUI() {
        detailsView.layer.cornerRadius = 15
        detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        posterView.layer.cornerRadius = 8
        posterView.layer.masksToBounds = true
    }
}

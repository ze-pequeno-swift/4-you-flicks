//
//  CardCustomCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class CardCustomCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CardCustomCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public Functions
    
    func setupMovieCell() {
        movieImage.image = UIImage(named: "ruamedo")
    }
    
    func setupSerieCell() {
        movieImage.image = UIImage(named: "luca")
    }
    
    func setupRecommendedCell() {
        movieImage.image = UIImage(named: "backwidow")
    }
    
    // MARK: - Private Functions

    private func setupUI() {
        movieImage.layer.cornerRadius = 10
    }
}

//
//  CustomMoviesTheatersCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class CustomMoviesTheatersCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CustomMoviesTheatersCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public Functions
    
    func setupMovieTheatersCell() {
        movieImage.image = UIImage(named: "posterviuva")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        movieImage.layer.cornerRadius = 10
    }
}

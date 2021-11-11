//
//  CardCustomDailyTrendingsCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class CardCustomDailyTrendingsCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CardCustomDailyTrendingsCell.self)
    }
    
    func setupUI(movie: Movie) {
        if let backdropPath = movie.backdropPath {
            movieImage.load(url: MovieAPI.build(image: backdropPath, size: .original))
        }
    
        movieImage.layer.cornerRadius = 10
    }
}

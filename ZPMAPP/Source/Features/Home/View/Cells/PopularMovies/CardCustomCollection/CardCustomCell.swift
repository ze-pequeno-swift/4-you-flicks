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
    
    // MARK: - Private Functions
    
    func setupUI(movie: Movie) {
        if let poster = movie.posterPath {
            movieImage.load(url: MovieAPI.build(image: poster, size: .original))
        }
    
        movieImage.layer.cornerRadius = 10
    }
}

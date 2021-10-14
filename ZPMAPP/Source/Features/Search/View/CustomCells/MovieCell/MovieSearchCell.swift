//  MovieSearchCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit
import Cosmos

class MovieSearchCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet  private weak var movieImageView: UIImageView!
    
    @IBOutlet  private weak var titleMovieLabel: UILabel!
    
    @IBOutlet private weak var starsRatingView: CosmosView!

    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: MovieSearchCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieImageView.setupCornerImage(cornerRadius: 10)
    }
    
    // MARK: - Public Functions
    
    public func setupSearchMovieCell(data: Movie) {

        if let posterPath = data.posterPath {
            movieImageView.load(url: MovieAPI.build(image: posterPath, size: .w500))
        }

        titleMovieLabel.text = data.title
        starsRatingView.rating = data.voteAverage / 2
    }
}

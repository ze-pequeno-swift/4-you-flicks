//  MovieSearchCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit

class MovieSearchCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet  private weak var titileMovieImageView: UIImageView!
    
    @IBOutlet  private weak var titleMovieLabel: UILabel!
    
    @IBOutlet  private weak var movieLengthLabel: UILabel!
    
    @IBOutlet  private weak var movieGenreLabel: UILabel!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: MovieSearchCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titileMovieImageView.setupCornerImage(cornerRadius: 10)
    }
    
    // MARK: - Public Functions
    
    public func setupSearchMovieCell(data: MovieList) {
        self.titleMovieLabel.text = data.title
        self.titileMovieImageView.image = UIImage(named: data.image ?? "")
        self.movieLengthLabel.text = data.length
        self.movieGenreLabel.text = data.genre
    }
}


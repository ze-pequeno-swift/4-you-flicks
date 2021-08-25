//  MovieCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit

class MovieCell: UITableViewCell {

    static let identifier: String = "movieSearchCell"

    @IBOutlet  private weak var titileMovieImageView: UIImageView!
    @IBOutlet  private weak var titleMovieLabel: UILabel!
    @IBOutlet  private weak var movieLengthLabel: UILabel!
    @IBOutlet  private weak var movieGenreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titileMovieImageView.setupCornerImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func setupSearchMovieCell(data: MovieList) {
        self.titleMovieLabel.text = data.title
        self.titileMovieImageView.image = UIImage(named: data.image ?? "")
        self.movieLengthLabel.text = data.length
        self.movieGenreLabel.text = data.genre
    }
}


//
//  MovieCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit

class MovieCell: UITableViewCell {

    static let identifier: String = "movieSearchCell"

    @IBOutlet weak var titileMovieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titileMovieImageView.setupCornerImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupSearchMovieCell(data: MovieList) {
        self.titleMovieLabel.text = data.title
        self.titileMovieImageView.image = UIImage(named: data.image)
        self.movieLengthLabel.text = data.length
        self.movieGenreLabel.text = data.genre
    }
}

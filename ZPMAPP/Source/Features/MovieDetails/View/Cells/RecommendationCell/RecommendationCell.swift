//
//  RecommendationCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 28/09/21.
//

import UIKit

class RecommendationCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var posterImage: UIImageView!

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.setupCornerImage(cornerRadius: 10)
    }

    // MARK: - Public Properties

    static var identifier: String {
        String(describing: RecommendationCell.self)
    }

    func setupCell(_ value: Movie?) {
        guard
            let movie = value,
            let imagePath = movie.posterPath else {
                return
            }

        posterImage.load(url: MovieAPI.build(image: imagePath, size: .w500)) {
        }
    }
}

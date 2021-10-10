//
//  RecommendationCell.swift
//  ZPMAPP
//
//  Created by Hellen on 10/10/21.
//

import UIKit

class SuggestionCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.setupCornerImage(cornerRadius: 10)
    }

    // MARK: - Public Properties

    static var identifier: String {
        String(describing: SuggestionCell.self)
    }

    func setupCell(_ value: Movie?) {
        guard let movie = value,
              let imagePath = movie.posterPath else { return }

        posterImage.load(url: MovieAPI.build(image: imagePath, size: .w500))
    }
}

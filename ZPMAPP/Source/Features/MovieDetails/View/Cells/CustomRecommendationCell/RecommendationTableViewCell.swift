//
//  RecommendationTableViewCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 27/09/21.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!

    private var recommendation: [Movie] = []

    // MARK: - Public Properties

    static var identifier: String {
        String(describing: RecommendationTableViewCell.self)
    }

    func setupCell(_ detail: Details?) {
        if let movie = detail {
            recommendation = movie.recommendations
        }

        print(recommendation)

        RecommendationCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol Extensions

extension RecommendationTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return recommendation.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = RecommendationCell.identifier

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? RecommendationCell else {
            return UICollectionViewCell()
        }

        cell.setupCell(recommendation[indexPath.item])
        return cell

    }
}

//
//  DailyTrendingsCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class DailyTrendingsCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private let controllerHome: ControllerHome = ControllerHome()
    
    // MARK: - Public Properties

    weak var delegate: HomeViewControllerDelegate?
    
    static var identifier: String {
        String(describing: DailyTrendingsCell.self)
    }

    // MARK: - Public Functions

    func didFetchMovie() {
        controllerHome.fetchDailyTrendings(value: .topTrending) { result, _ in
            guard result else { return }
            self.collectionView.reloadData()
            self.setupUI()
        }
    }

    // MARK: - Private Functions
    
    func setupUI() {
        CardCustomDailyTrendingsCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol Extensions

extension DailyTrendingsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllerHome.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CardCustomDailyTrendingsCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? CardCustomDailyTrendingsCell else { return UICollectionViewCell() }
        
        cell.setupUI(movie: controllerHome.getMovie(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell(selectedMovie: controllerHome.movieList[indexPath.item])
    }
}

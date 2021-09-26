//
//  TopCustomCell.swift
//  ZPMAPP
//
//  Created by Alan Silva on 06/09/21.
//

import UIKit

class TopCustomCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private let controllerHome: ControllerHome = ControllerHome()
    
    // MARK: - Public Properties
    
    weak var delegate: HomeViewControllerDelegate?

    static var identifier: String {
        String(describing: TopCustomCell.self)
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        CardCustomCell.registerOn(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Public Functions
    
    func didFetchMovie(value: HomeSection) {
        controllerHome.fetchMovieList(value: value) { result, _ in
            guard result else { return }
            self.collectionView.reloadData()
            self.setupUI()
        }
    }
}

// MARK: - UICollectionView Protocol Extensions

extension TopCustomCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllerHome.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CardCustomCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? CardCustomCell else { return UICollectionViewCell() }
    
        cell.setupUI(movie: controllerHome.getMovie(indexPath: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell(selectedMovie: controllerHome.movieList[indexPath.item])
    }
}

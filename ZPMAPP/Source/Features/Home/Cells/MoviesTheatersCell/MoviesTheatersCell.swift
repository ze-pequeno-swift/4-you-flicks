//
//  MoviesTheatersCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class MoviesTheatersCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public Properties
    
    weak var delegate: HomeViewControllerDelegate?
    
    class var identifier: String {
        String(describing: MoviesTheatersCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private Functions

    private func setupUI() {
        CustomMoviesTheatersCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol Extensions

extension MoviesTheatersCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CustomMoviesTheatersCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CustomMoviesTheatersCell else { return UICollectionViewCell() }
   
        cell.setupMovieTheatersCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell()
        print("DEBUG: Nos cinemas..")
    }
}

//
//  PopularMoviesCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class PopularMoviesCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public Properties
    
    weak var delegate: HomeViewControllerDelegate?
    
    static var identifier: String {
        String(describing: PopularMoviesCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        CustomCollectionCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol Extensions

extension PopularMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CustomCollectionCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CustomCollectionCell else { return UICollectionViewCell() }
        
        cell.setupMovieCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell()
        print("DEBUG: Filmes populares..")
    }
}

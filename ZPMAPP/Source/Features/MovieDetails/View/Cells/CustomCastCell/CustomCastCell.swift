//
//  CustomCastCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class CustomCastCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var castList: [Cast] = []
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CustomCastCell.self)
    }
    
    // MARK: - Public Functions
    
    func setupCell(_ details: Details?) {
        guard let movie = details else { return }
        
        castList = movie.cast
        
        CastCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}


// MARK: - UICollectionView Protocol Extensions

extension CustomCastCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CastCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CastCell else { return UICollectionViewCell() }
        
        cell.setup(castList[indexPath.item])
        return cell
    }
}

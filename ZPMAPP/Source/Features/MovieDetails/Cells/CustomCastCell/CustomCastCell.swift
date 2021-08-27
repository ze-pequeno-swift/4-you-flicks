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
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CustomCastCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private Functions

    private func setupUI() {
        CastCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol Extensions

extension CustomCastCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CastCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CastCell else { return UICollectionViewCell() }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG: Cast cell..")
    }
}

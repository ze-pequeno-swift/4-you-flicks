//
//  TopCustomCell.swift
//  ZPMAPP
//
//  Created by Alan Silva on 06/09/21.
//

import UIKit

class TopCustomCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: HomeViewControllerDelegate?
    
    static var identifier: String {
        String(describing: TopCustomCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        CustomCollectionCell.registerOn(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TopCustomCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CustomCollectionCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? CustomCollectionCell else { return UICollectionViewCell() }
        
        cell.setupMovieCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell()
        print("DEBUG: Filmes populares..")
    }
}

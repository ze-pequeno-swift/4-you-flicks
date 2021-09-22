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
    let controllerHome: ControllerHome = ControllerHome()
    
    // MARK: - Public Properties
    
    weak var delegate: HomeViewControllerDelegate?
    
    static var identifier: String {
        String(describing: TopCustomCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        CardCustomCell.registerOn(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getData(value: HomeSection) {
        controllerHome.getData(value: value) { result, _ in
            if result {
                self.collectionView.reloadData()
                self.setupUI()
            } else { }
        }
    }
}

// MARK: - UICollectionView Protocol Extensions

extension TopCustomCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllerHome.getQtd()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CardCustomCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? CardCustomCell else { return UICollectionViewCell() }
    
        cell.setupUI(value: controllerHome.getInfoData(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell()
        print("DEBUG: Clicou em uma cell de filmes..")
    }
}

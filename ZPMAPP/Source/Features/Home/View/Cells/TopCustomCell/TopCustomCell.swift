//
//  TopCustomCell.swift
//  ZPMAPP
//
//  Created by Alan Silva on 06/09/21.
//

import UIKit

class TopCustomCell: UITableViewCell {
    
    let homeController: HomeController = HomeController()
    
    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    
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
    func getData(apiPath: HomeSection) {
        homeController.getData(filename: apiPath) { result, error in
           if result {
              self.setupUI()
           }else {
               print(error)
           }
       }
    }
}

// MARK: - UICollectionView Protocol Extensions

extension TopCustomCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeController.getQtyData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CardCustomCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? CardCustomCell else { return UICollectionViewCell() }
    
        cell.setupUI(value: homeController.getInfoData(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell()
        print("DEBUG: Clicou em uma cell de filmes..")
    }
}

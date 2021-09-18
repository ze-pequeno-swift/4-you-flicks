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
    
    let controllerHome: ControllerHome = ControllerHome()
    
    // MARK: - Public Properties

    static var identifier: String {
        String(describing: DailyTrendingsCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func getData() {
        controllerHome.getData(value: .topTrending) { result, _ in
            if result {
                self.setupUI()
            } else {  }
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
        return controllerHome.getQtd()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = CardCustomDailyTrendingsCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CardCustomDailyTrendingsCell else { return UICollectionViewCell() }
        
        cell.setupUI(value: controllerHome.getInfoData(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG: Nos cinemas..")
    }
}

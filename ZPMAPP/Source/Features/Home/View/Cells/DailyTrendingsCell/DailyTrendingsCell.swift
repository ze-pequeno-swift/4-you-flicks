//
//  DailyTrendingsCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit

class DailyTrendingsCell: UITableViewCell {

    // MARK: - IBOutlets
    var dataTopTrending: [DataMovies] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let homeController: HomeController = HomeController()
    
    // MARK: - Public Properties

    static var identifier: String {
        String(describing: DailyTrendingsCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

    // MARK: - Private Functions

    private func setupUI() {
        CardCustomDailyTrendingsCell.registerOn(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - UICollectionView Protocol Extensions

extension DailyTrendingsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("####Linha\(homeController.getQtyData())")
        return homeController.getQtyData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CardCustomDailyTrendingsCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CardCustomDailyTrendingsCell else { return UICollectionViewCell() }
        
        cell.setupUI(value: homeController.getInfoData(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG: Nos cinemas..")
    }
}

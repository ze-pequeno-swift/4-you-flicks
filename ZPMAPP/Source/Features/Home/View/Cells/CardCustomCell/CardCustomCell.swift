//
//  CardCustomCell.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import UIKit
import SDWebImage


class CardCustomCell: UICollectionViewCell {
    
    let homeController: HomeController = HomeController()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CardCustomCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private Functions

    func setupUI(value: DataMovies) {
        let url = homeController.extracImage(data: value.poster_path ?? "")
        movieImage.sd_setImage(with: url)
        movieImage.layer.cornerRadius = 10
    }
}

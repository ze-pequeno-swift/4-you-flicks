//
//  CastCell.swift
//  ZPMAPP
//
//  Created by Hellen on 26/08/21.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var castImage: UIImageView!
    
    @IBOutlet private var title: UILabel!
    
    @IBOutlet private var subtitle: UILabel!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: CastCell.self)
    }

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castImage.layer.cornerRadius = 0.5 * castImage.bounds.size.width
        castImage.clipsToBounds = true
    }
    
    func setup(_ cast: Cast?) {
        guard let cast = cast else { return }
        
        if let profilePath = cast.profilePath {
            castImage.load(url: MovieAPI.build(image: profilePath, size: .w500))
        }
        
        title.text = cast.name
        subtitle.text = cast.character
    }
}

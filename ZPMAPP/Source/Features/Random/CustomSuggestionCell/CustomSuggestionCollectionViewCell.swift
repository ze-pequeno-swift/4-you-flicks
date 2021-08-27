//
//  CustomSuggestionCollectionViewCell.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 27/08/21.
//

import UIKit

class CustomSuggestionCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImageView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
        
        
    }

}

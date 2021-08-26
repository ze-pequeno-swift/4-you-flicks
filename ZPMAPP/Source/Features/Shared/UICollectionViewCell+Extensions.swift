//
//  UICollectionViewCell+Extensions.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static func registerOn(_ collectionView: UICollectionView) {
        let reuseIdentifier = String(describing: self.self)
        let nib = UINib(nibName: reuseIdentifier, bundle: Bundle(for: self.self))
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

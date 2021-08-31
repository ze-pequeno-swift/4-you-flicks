//
//  UIImageView+Extension.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit

extension UIImageView {
    
    func setupCornerImage(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func circleCornerImage() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}

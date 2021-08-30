//
//  ExtensionUIView.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 10/08/21.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(cornerRadius: CGFloat, typeCorners: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = typeCorners
        self.clipsToBounds = true
    }
}

extension CACornerMask {
    
    static public let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    static public let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}

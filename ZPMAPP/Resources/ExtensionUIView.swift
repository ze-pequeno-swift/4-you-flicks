//
//  ExtensionUIView.swift
//  ShopList
//
//  Created by Vitor Lentos on 10/08/21.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(cornerRadius:CGFloat, typeCorners:CACornerMask){
        self.layer.cornerRadius = cornerRadius;
        self.layer.maskedCorners = typeCorners;
        self.clipsToBounds = true;
    }
}

extension CACornerMask {
    
    static public let inferiorDireito:CACornerMask = .layerMaxXMaxYCorner;
    static public let inferiorEsquerdo:CACornerMask = .layerMinXMaxYCorner;
    static public let superiorDireito:CACornerMask = .layerMaxXMinYCorner;
    static public let superiorEsquerdo:CACornerMask = .layerMinXMinYCorner;
    
}

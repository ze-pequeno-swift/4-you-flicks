//
//  UIColor+Extensions.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 23/08/21.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }

    static let customRed: UIColor = UIColor(red: 255, green: 45, blue: 61)
    static let customDarkGray: UIColor = UIColor(red: 35, green: 33, blue: 38)
}

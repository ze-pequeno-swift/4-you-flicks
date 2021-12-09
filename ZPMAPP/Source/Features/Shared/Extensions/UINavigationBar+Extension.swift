//
//  UINavigationBar+Extension.swift
//  ZPMAPP
//
//  Created by Hellen on 26/08/21.
//

import UIKit

extension UINavigationBar {
    
    func navigationStyle() {
        let fontColor = UIColor.customRed
        let fontSystem = UIFont.systemFont(ofSize: 15)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .black
            appearance.titleTextAttributes = [.foregroundColor: fontColor, .font: fontSystem]
            self.isTranslucent = false
            self.tintColor = .customRed
            self.standardAppearance = appearance
            self.scrollEdgeAppearance = appearance
            self.compactAppearance = appearance

        } else {
            self.isTranslucent = false
            self.tintColor = .customRed
            self.barTintColor = .black
            self.backgroundColor = .white
            self.barStyle = UIBarStyle.black
            self.titleTextAttributes = [.foregroundColor: fontColor, .font: fontSystem]
        }
    }
}

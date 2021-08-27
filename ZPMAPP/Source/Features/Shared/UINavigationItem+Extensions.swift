//
//  UINavigationItem+Extensions.swift
//  ZPMAPP
//
//  Created by Hellen on 26/08/21.
//

import UIKit

extension UINavigationItem {
    
    func backButton(_ target: Any?, action: Selector?) {
        backButton(target: target, action: action)
    }
    
    func backButton(target: Any?, action: Selector?) {
        setupButton(image: UIImage(named: "icon-back"), target: target, action: action)
    }
    
    func closeButton(_ target: Any?, action: Selector?) {
        closeButton(target: target, action: action)
    }
    
    func closeButton(target: Any?, action: Selector?) {
        setupButton(image: UIImage(named: "icon-close"), target: target, action: action)
    }
    
    private func setupButton(image: UIImage?, target: Any?, action: Selector?) {
        let button = UIBarButtonItem(
            image: image, landscapeImagePhone: nil,
            style: UIBarButtonItem.Style.plain,
            target: target, action: action)
        
        button.accessibilityIdentifier = "backButtonId"
        self.leftBarButtonItem = button
    }
}

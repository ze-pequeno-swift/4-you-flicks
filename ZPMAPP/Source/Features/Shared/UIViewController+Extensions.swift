//
//  UIViewController+Extensions.swift
//  ZPMAPP
//
//  Created by Hellen on 26/08/21.
//

import UIKit

extension UIViewController {
    
    @objc
    func close() {
        let viewController = navigationController?.popViewController(animated: true)
        if viewController == nil {
            navigationController?.dismiss(animated: true)
        }
    }
}

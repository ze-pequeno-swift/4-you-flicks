//
//  UITableViewCell+Extensions.swift
//  ZPMAPP
//
//  Created by Hellen on 23/08/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func registerOn(_ tableView: UITableView) {
        let reuseIdentifier = String(describing: self.self)
        let nib = UINib(nibName: reuseIdentifier, bundle: Bundle(for: self.self))
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}

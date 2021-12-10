//
//  FBLoginButton+Extensions.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 28/11/21.
//

import UIKit
import FBSDKLoginKit

extension FBLoginButton {
    func setup(title: String) {
        for constraint in self.constraints where constraint.firstAttribute == .height {
            constraint.constant = 48
        }

        self.roundCornersAll(cornerRadius: 5)
        self.backgroundColor = UIColor(named: "Facebook")
        self.setAttributedTitle(NSAttributedString(string: title), for: .normal)
        self.permissions = ["public_profile", "email"]
    }
}

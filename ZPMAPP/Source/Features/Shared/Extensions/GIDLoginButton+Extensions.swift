//
//  GIDLoginButton+Extensions.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 07/12/21.
//

import UIKit
import GoogleSignIn

extension GIDSignInButton {
    func setup() {
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.roundCornersAll(cornerRadius: 5)
        self.style = .iconOnly
    }
}

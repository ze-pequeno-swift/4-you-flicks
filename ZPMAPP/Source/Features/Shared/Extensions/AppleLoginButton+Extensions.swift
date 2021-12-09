//
//  AppleLoginButton+Extensions.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 09/12/21.
//

import UIKit
import AuthenticationServices

extension ASAuthorizationAppleIDButton {
    func setup(title: String) {
        type(of: self).init(type: .signIn, style: .whiteOutline)
        self.roundCornersAll(cornerRadius: 5)
    }
}

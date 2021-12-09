//
//  FacebookButton.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 28/11/21.
//

import UIKit
import FBSDKLoginKit

class FacebookButton: FBLoginButton {
    static var title: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton(FacebookButton.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(_ title: String) {
        self.backgroundColor = UIColor(named: "Facebook")
        self.titleLabel?.font = UIFont(name: "Arial", size: 18)
        self.setAttributedTitle(NSAttributedString(string: title), for: .normal)
        self.layer.cornerRadius = frame.size.height/2
        self.setTitleColor(.white, for: .normal)

        self.permissions = ["public_profile", "email"]
    }
}

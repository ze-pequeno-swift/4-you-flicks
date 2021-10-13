//
//  LoginController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 12/10/21.
//

import Foundation

protocol LoginControllerProtocol: AnyObject {
    func sucess()
}

class LoginController {
    
    weak var delegate: LoginControllerProtocol?
    
    func sucess() {
        self.delegate?.sucess()
    }
    
}

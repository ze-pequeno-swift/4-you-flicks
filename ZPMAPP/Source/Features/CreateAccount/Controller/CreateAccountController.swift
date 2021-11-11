//
//  CreateAccountController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 23/09/21.
//

import Foundation



protocol CreateAccountControllerProtocol: AnyObject {
    func sucess()
    func failure(error: Error?)
}

class CreateAccountController {
    
    // MARK: - Var
    let firebase: FirebaseDataService!
    var customer: Customer?
    weak var delegate: CreateAccountControllerProtocol?
    
    init() {
        self.firebase = FirebaseDataService()
        self.firebase.delegate = self
    }
    
    
    // MARK: - Funcs
    
    func createAccount(name: String, email: String, password: String) {
        self.firebase.createUser(name: name, email: email, password: password)
    }
}

extension CreateAccountController: FirebaseDataServiceProtocol {
    func success(_ collection: String) {
        if collection == "login" {
            self.delegate?.sucess()
        }
    }
    
    func failure(error: Error?) {
        self.delegate?.failure(error: error)
    }
}

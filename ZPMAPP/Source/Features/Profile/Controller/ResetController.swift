//
//  ResetController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

protocol ResetControllerProtocol: AnyObject {
    func sendRecoveryPassword()
    func sendErrorRecoveryPassword()
}

class ResetController {

    var customer: Customer?
    let firebase: FirebaseDataService!
    
    weak var delegate: ResetControllerProtocol?
    
    init(customer: Customer?) {
        self.customer = customer
        self.firebase = FirebaseDataService()
        self.firebase.delegate = self
        self.firebase.delegateRecovery = self
    }
    
    func getCustomer() -> Customer? {
        return self.customer
    }
    
    func setCustomer() {
        self.customer = self.firebase.loadCustomer()
    }
    
    func resetPassword(password: String, oldPassword: String) {
        self.firebase.resetPassword(password: password)
    }
    
    func recoveryPassword() {
        self.firebase.recoveryPassword()
    }
}

extension ResetController: FirebaseDataServiceProtocol, FirebaseRecoveryPasswordProtocol {
    func success(_ collection: String) {
        if collection == "users" {
            self.setCustomer()
        }
    }
    
    func failure(error: Error?) {
        print(error)
    }
    
    func recovery() {
        self.delegate?.sendRecoveryPassword()
    }
    
    func errorRecovery(error: Error?) {
        print("error")
    }
}

//
//  ResetController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

protocol ResetControllerProtocol: AnyObject {
    func success()
    func failure(error: Error?)
    func sendRecoveryPassword()
    func sendErrorRecoveryPassword(error: Error?)
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
        self.firebase.resetPassword(password: password, oldPassword: oldPassword)
    }
    
    func recoveryPassword() {
        guard let email = self.customer?.email else { return }
        self.firebase.recoveryPassword(email: email)
    }
}

extension ResetController: FirebaseDataServiceProtocol, FirebaseRecoveryPasswordProtocol {
    func success(_ collection: String) {
        if collection == "users" {
            self.setCustomer()
            self.delegate?.success()
        }
    }
    
    func failure(error: Error?) {
        self.delegate?.failure(error: error)
    }
    
    func recovery() {
        self.delegate?.sendRecoveryPassword()
    }
    
    func errorRecovery(error: Error?) {
        self.delegate?.sendErrorRecoveryPassword(error: error)
    }
}

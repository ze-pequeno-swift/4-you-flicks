//
//  RecoverPasswordController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 09/11/21.
//

import Foundation

protocol RecoverPasswordControllerProtocol: AnyObject {
    func success()
    func failure(error: Error?)
}

class RecoverPasswordController {
    
    // MARK: - Var

    let firebase: FirebaseDataService!
    weak var delegate: RecoverPasswordControllerProtocol?
    
    init() {
        self.firebase = FirebaseDataService()
        self.firebase.delegateRecovery = self
    }
    
    func recoveryPassword(email: String) {
        self.firebase.recoveryPassword(email: email)
    }
}

extension RecoverPasswordController: FirebaseRecoveryPasswordProtocol {
    func recovery() {
        self.delegate?.success()
    }
    
    func errorRecovery(error: Error?) {
        self.delegate?.failure(error: error)
    }
}

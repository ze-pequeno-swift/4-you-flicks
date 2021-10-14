//
//  EditController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

class EditController {
    
    var customer: Customer?
    let firebase: FirebaseDataService!
    
    init(customer: Customer?) {
        self.customer = customer
        self.firebase = FirebaseDataService()
        self.firebase.delegate = self
    }
    
    func getCustomer() -> Customer? {
        return self.customer
    }
    
    func updateCustomer(name: String, username: String, email: String) {
        if var customer = self.customer {
            customer.name = name
            customer.username = username
            customer.email = email
            
            self.firebase.updateUser(customerData: customer, password: nil)
        }
    }
    
    func validUsername(value: String?) -> Bool {
        if let _value = value {
            let index = _value.index(_value.startIndex, offsetBy: 0)
            return _value[index] == "@"
        }
        return false
    }
    
    func uploadAvatar(path: URL) {
        self.firebase.uploadAvatar(localFile: path)
    }
    
    private func setCustomer() {
        self.customer = self.firebase.loadCustomer()
    }
}

extension EditController: FirebaseDataServiceProtocol {
    
    func success(_ collection: String) {
        if collection == "users" {
            self.setCustomer()
        }
    }
    
    func failure(error: Error?) {
        print("error")
    }
}

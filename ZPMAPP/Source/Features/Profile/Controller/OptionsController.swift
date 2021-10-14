//
//  OptionsController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

class OptionsController {
    
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

}

extension OptionsController: FirebaseDataServiceProtocol {
    func success(_ collection: String) {
        print("OK Option")
    }
    
    func failure(error: Error?) {
        print("error")
    }
}

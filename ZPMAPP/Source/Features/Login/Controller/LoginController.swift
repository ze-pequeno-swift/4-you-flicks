//
//  LoginController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 12/10/21.
//

import Foundation

protocol LoginControllerProtocol: AnyObject {
    func sucess()
    func failure(error: String)
}

class LoginController {
    
    weak var delegate: LoginControllerProtocol?
    let firebase: FirebaseDataService!
    
    init() {
        self.firebase = FirebaseDataService()
        self.firebase.delegate = self
    }
    
    func userIsLogged() -> Bool {
        return FirebaseDataService.userIsLoggedIn()
    }
    
    func login(email: String, password: String) {
        self.firebase.login(email: email, password: password)
    }
    
    func errorLoginFirebase(error: Error?) -> String {
        guard let _error = error else { return "Houve um erro na autenticação" }
        switch _error._code {
        case 17010:
            return "O acesso a esta conta foi temporariamente desativado devido a muitas tentativas de login malsucedidas. Você pode restaurá-lo imediatamente redefinindo sua senha ou pode tentar novamente mais tarde."
        default:
            print("CODE: \(_error._code)")
            return "Usuário ou senha são inválidos."
        }
    }
}

extension LoginController: FirebaseDataServiceProtocol {
    func success(_ collection: String) {
        if collection == "login" {
            self.delegate?.sucess()
        }
    }
    
    func failure(error: Error?) {
        let message = self.errorLoginFirebase(error: error)
        self.delegate?.failure(error: message)
    }
}

//
//  CreateAccountController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 23/09/21.
//

import Foundation
import UIKit



protocol CreateAccounteControllerProtocol: AnyObject {
    func showError()
}

class CreateAccountController {
    
    // MARK: - Var
    var message: String = ""
    weak var delegate: CreateAccounteControllerProtocol?
    
    // MARK: - Funcs
    
    func basic(name: String?, email: String?, emailConf: String?, password: String?, passwordConf: String?) {
        var basicReturn: String = verifyTextFields(name: name, email: email, emailConf: emailConf, password: password, passwordConf: passwordConf)
        if basicReturn != "" {
            self.message = basicReturn
            print(message)
            self.delegate?.showError()
        } else {
            basicReturn = "Deu certo"
            print(basicReturn)
        }
    }
    
    func returnString(campo: String?) -> String {
        if let texto: String = campo {
            print(texto)
            return texto
        }
        print("vazio")
        return ""
    }
    
    func verifyTextFields(name: String?, email: String?, emailConf: String?, password: String?, passwordConf: String?) -> String {
        if name?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Por favor, preencha o nome corretamente"
        } else if email?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Por favor, preencha o email corretamente"
        } else if emailConf?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Por favor, preencha a confirmação do email corretamente"
        } else if password?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Por favor, defina uma senha"
        } else if passwordConf?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Por favor, preencha o campo de confirmação de senha corretamente"
        }
        return ""
    }
    
    func showError(mensagem: String) -> UIAlertController {
        let alert = UIAlertController(title: "ERRO", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }
    
}

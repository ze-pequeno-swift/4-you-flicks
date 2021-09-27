//
//  CreateAccountController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 23/09/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth



protocol CreateAccounteControllerProtocol: AnyObject {
    func showAlert()
}

class CreateAccountController {
    
    // MARK: - Var
    var messageAlert: String = ""
    var titleAlert: String = ""
    weak var delegate: CreateAccounteControllerProtocol?
    
    // MARK: - Funcs
    
    func basic(name: String?, email: String?, emailConf: String?, password: String?, passwordConf: String?) {
        messageAlert = verifyTextFields(name: name, email: email, emailConf: emailConf, password: password, passwordConf: passwordConf)
        if messageAlert == "" {
            messageAlert = verifyConfirmationFields(field: "Email", fieldTextOne: email, fieldTextTwo: emailConf)
            if messageAlert == ""{
                messageAlert = verifyConfirmationFields(field: "Senha", fieldTextOne: password, fieldTextTwo: passwordConf)
                if messageAlert == ""{
                    Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { _, error in
                        if error != nil {
                            self.titleAlert = "ERRO"
                            self.messageAlert = error?.localizedDescription ?? ""
                        }
                    }
                }
            }
        }
        
        
        if messageAlert != "" {
            self.delegate?.showAlert()
        } else {
            self.titleAlert = "Sucesso"
            self.messageAlert = "Cadastro concluído com sucesso. Bem vindo(a)."
            self.delegate?.showAlert()
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
            self.titleAlert = "ERRO"
            return "Por favor, preencha o nome corretamente"
        } else if email?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.titleAlert = "ERRO"
            return "Por favor, preencha o email corretamente"
        } else if emailConf?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.titleAlert = "ERRO"
            return "Por favor, preencha a confirmação do email corretamente"
        } else if password?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.titleAlert = "ERRO"
            return "Por favor, defina uma senha"
        } else if passwordConf?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.titleAlert = "ERRO"
            return "Por favor, preencha o campo de confirmação de senha corretamente"
        }
        return ""
    }
    
    func verifyConfirmationFields(field: String, fieldTextOne: String?, fieldTextTwo: String?) -> String {
        if fieldTextOne == fieldTextTwo {
            return ""
        } else {
            self.titleAlert = "ERRO"
            return "\(field)s não são iguais, favor verificar"
        }
    }
    
    func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }
    
}

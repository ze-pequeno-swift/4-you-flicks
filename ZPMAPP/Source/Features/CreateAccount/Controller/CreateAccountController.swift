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



protocol CreateAccountControllerProtocol: AnyObject {
    func showAlert()
    func sucess()
}

class CreateAccountController {
    
    // MARK: - Var
    var messageAlert: String = "."
    var titleAlert: String = ""
    weak var delegate: CreateAccountControllerProtocol?
    
    // MARK: - Funcs
    
    func basic(name: String?, email: String?, emailConf: String?, password: String?, passwordConf: String?) {
        messageAlert = verifyTextFields(name: name, email: email, emailConf: emailConf, password: password, passwordConf: passwordConf)
        if messageAlert == "" {
            messageAlert = verifyConfirmationFields(field: "Email", fieldTextOne: email, fieldTextTwo: emailConf)
            if messageAlert == ""{
                messageAlert = verifyConfirmationFields(field: "Senha", fieldTextOne: password, fieldTextTwo: passwordConf)
                if messageAlert == "" {
                    Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { _, error in
                        if error != nil {
                            self.titleAlert = "ERRO"
                            self.messageAlert = error?.localizedDescription ?? ""
                            print("DEU ERRO AQUI")
                            self.delegate?.showAlert()
                        } else {
                            print("Passou por aqui")
                            self.titleAlert = "Sucesso"
                            self.messageAlert = "Cadastro concluído com sucesso. Por favor, faça o login no aplicativo com as informações cadastradas."
                            self.delegate?.showAlert()
                        }
                    }
                }
            }
        }
        
        
        if messageAlert != "" {
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
        if title=="Sucesso" {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                self.delegate?.sucess()
            }))
            return alert
        } else {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            return alert
        }
    }
    
}

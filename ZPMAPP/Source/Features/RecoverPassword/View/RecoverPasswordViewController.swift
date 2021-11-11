//
//  AlterarSenhaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class RecoverPasswordViewController: UIViewController {
    
    var invalid: Bool = false
    var email: String?
    let controller = RecoverPasswordController()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidLabel: UILabel!
    
    // MARK: - Private Properties
    
    private let passwordlImageRight = UIImageView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.controller.delegate = self
    }
    
    // MARK: - Button Action
    
    @IBAction func sendRecoverButton(_ sender: UIButton) {
        if self.invalid {
            self.alert(title: "Erro", message: "Existem campos inválidos, favor corrigir")
            return
        }
        
        guard let email = self.emailTextField?.text else { return }
        self.controller.recoveryPassword(email: email)
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        let passwordlImage = UIImage(systemName: "mail")
        addLeftImageTo(textField: emailTextField, andImage: passwordlImage!)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Digite seu e-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        emailTextField.delegate = self
    }
    
    private func validateField(input: UITextField, type: Field) {
        if !input.isEmail() {
            self.invalidFieldUI(input)
            self.emailValidLabel.text = "O e-mail é inválido"
            return
        }
        if input.isEmpty() {
            self.invalidFieldUI(input)
            self.emailValidLabel.text = "O \(type.rawValue) não pode ficar em branco"
            return
        }
        if !input.min(qty: 3) {
            self.invalidFieldUI(input)
            self.emailValidLabel.text = "Precisa ter pelo menos 3 caracteres no campo\(type.rawValue)"
            return
        }
        
        input.validFieldWhite()
        self.validFieldUI()
    }
    
    private func validFieldUI() {
        self.invalid = false
        self.emailValidLabel.text = ""
    }
    
    private func invalidFieldUI(_ input: UITextField) {
        input.invalidField()
        self.invalid = true
    }
    
    private func alert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            if title != "Erro" {
                self.dismiss(animated: true)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension RecoverPasswordViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateField(input: textField, type: .email)
    }
}

extension RecoverPasswordViewController: RecoverPasswordControllerProtocol {
    func success() {
        self.emailTextField.text = ""
        self.alert(title: "Recuperação de Senha", message: "Você receberá um e-mail para efetuar sua recuperação de senha, verifique em sua caixa de e-mail, span ou lixeira")
    }
    
    func failure(error: Error?) {
        print(error?.localizedDescription)
        self.alert(title: "Erro", message: "Ixee, ocorreu um erro ao tentar recuperar sua senha, não desanime, tente novamente!")
    }
}

//
//  CriarContaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var createAccountButton: UIButton!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameValidLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidLabel: UILabel!
    
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var emailConfirmationValidLabel: UILabel!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var passwordConfirmationValidLabel: UILabel!
    
    // MARK: - Vars
    let controller = CreateAccountController()
    var invalid = false
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupKeyboard()
        self.controller.delegate = self
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        let personImage = UIImage(systemName: "person")
        addLeftImageTo(textField: nameTextField, andImage: personImage!)
        
        let emailImage = UIImage(systemName: "mail")
        addLeftImageTo(textField: emailTextField, andImage: emailImage!)
        addLeftImageTo(textField: emailConfirmationTextField, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "lock")
        addLeftImageTo(textField: passwordTextField, andImage: passwordlImage!)
        addLeftImageTo(textField: passwordConfirmationTextField, andImage: passwordlImage!)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Nome Completo",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        emailConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Digite o e-mail novamente",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Digite a senha novamente",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmationTextField.delegate = self
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y = 280 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - Actions
    @IBAction func signUp(_ sender: UIButton) {
        if self.invalid {
            self.alert(title: "Erro", message: "Não foi possível criar uma conta, existem campos inválidos, favor corrigir")
        }
        
        guard let name = self.nameTextField.text else { return }
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        
        self.controller.createAccount(name: name, email: email, password: password)
    }
    
    private func validateField(input: UITextField, type: Field) {
        switch type {
        case .name:
            if !self.defaultValidate(input: input, type: type, label: self.nameValidLabel, min: 3) {
                return
            }
        case .email:
            if !input.isEmail() {
                self.invalidFieldUI(input)
                self.emailValidLabel.text = "O e-mail é inválido"
                return
            }
            if !self.defaultValidate(input: input, type: type, label: self.emailValidLabel, min: 3) {
                return
            }
        case .confirmEmail:
            if input.text != self.emailTextField.text {
                self.invalidFieldUI(input)
                self.emailConfirmationValidLabel.text = "Os e-mails não são iguais"
                return
            }
            if !self.defaultValidate(input: input, type: type, label: self.emailConfirmationValidLabel, min: 3) {
                return
            }
        case .password:
            if !input.isPasswordValid() {
                self.invalidFieldUI(input)
                self.passwordValidLabel.text = "O password deve conter pelo menos 6 caracteres, letra maiúscula e minúscula e um caracter especial"
                return
            }
            if !self.defaultValidate(input: input, type: type, label: self.passwordValidLabel, min: 5) {
                return
            }
        case .confirmPassword:
            if input.text != self.passwordTextField.text {
                self.invalidFieldUI(input)
                self.passwordConfirmationValidLabel.text = "As senhas não são iguais"
                return
            }
            if !self.defaultValidate(input: input, type: type, label: self.passwordConfirmationValidLabel, min: 5) {
                return
            }
        default:
            break
        }
        
        input.validFieldWhite()
        self.validFieldUI()
    }
    
    private func defaultValidate(input: UITextField, type: Field, label: UILabel, min: Int) -> Bool {
        if input.isEmpty() {
            self.invalidFieldUI(input)
            label.text = "O \(type.rawValue) não pode ficar em branco"
            return false
        }
        if !input.min(qty: min) {
            self.invalidFieldUI(input)
            label.text = "Precisa ter pelo menos \(min) caracteres no campo\(type.rawValue)"
            return false
        }
        
        return true
    }
    
    private func emptyFieldUI() {
        self.nameTextField.text = ""
        self.emailTextField.text = ""
        self.emailConfirmationTextField.text = ""
        self.passwordTextField.text = ""
        self.passwordConfirmationTextField.text = ""
    }
    
    private func validFieldUI() {
        self.invalid = false
        self.nameValidLabel.text = ""
        self.emailValidLabel.text = ""
        self.emailConfirmationValidLabel.text = ""
        self.passwordValidLabel.text = ""
        self.passwordConfirmationValidLabel.text = ""
    }
    
    private func invalidFieldUI(_ input: UITextField) {
        input.invalidField()
        self.invalid = true
    }
    
    private func alert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            if !self.invalid {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateAccountViewController: CreateAccountControllerProtocol {
    func failure(error: Error?) {
        print(error?.localizedDescription ?? "")
        self.invalid = true
        self.alert(title: "Erro", message: "Usuário ou senha incorretos")
    }
    
    func sucess() {
        self.invalid = false
        self.emptyFieldUI()
        self.alert(title: "Autenticação", message: "Seja bem vindo! Informe seu e-mail e senha cadastrado para logar")
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let identifier = textField.accessibilityIdentifier else { return true }

        switch identifier {
        case Field.name.rawValue:
            self.emailTextField.becomeFirstResponder()

        case Field.email.rawValue:
            self.emailConfirmationTextField.becomeFirstResponder()

        case Field.confirmEmail.rawValue:
            self.passwordTextField.becomeFirstResponder()

        case Field.password.rawValue:
            self.passwordConfirmationTextField.becomeFirstResponder()

        default:
            textField.resignFirstResponder()
        }

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let identifier = textField.accessibilityIdentifier else { return }

        switch identifier {
        case Field.name.rawValue:
            self.validateField(input: textField, type: .name)

        case Field.email.rawValue:
            self.validateField(input: textField, type: .email)

        case Field.confirmEmail.rawValue:
            self.validateField(input: textField, type: .confirmEmail)

        case Field.password.rawValue:
            self.validateField(input: textField, type: .password)

        case Field.confirmPassword.rawValue:
            self.validateField(input: textField, type: .confirmPassword)
        default:
            break
        }
    }
}

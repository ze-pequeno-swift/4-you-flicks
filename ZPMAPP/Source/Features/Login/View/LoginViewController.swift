//
//  LoginViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 23/08/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailValidLabel: UILabel!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    // MARK: - Private Properties
    
    private let passwordlImageRight = UIImageView()
    private var iconClick = false
    private var emailGeneral = ""
    private var passwordGeneral = ""
    private var invalid = false
    let controller = LoginController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoginIfNeeded()
        self.setupUI()
        self.controller.delegate = self
        navigationController?.navigationBar.isHidden = true
        configureKeyboardType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isModalInPresentation = true
    }
        
    // MARK: - Private Functions
    
    private func showLoginIfNeeded() {
        if !self.controller.userIsLogged() {
            return
        }

        self.proceedToHome()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if self.invalid {
            self.alert(title: "Erro", message: "Existem campos não preenchidos ou inválidos, verifique")
        }

        guard let _email = userTextField.text else { return }
        guard let _password = passwordTextField.text else { return }
        self.controller.login(email: _email, password: _password)
    }

    private func configureKeyboardType() {
        userTextField.keyboardType = .emailAddress
    }
    
    private func setupUI() {
        let emailImage = UIImage(systemName: "mail")
        addLeftImageTo(textField: userTextField, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "lock")
        addLeftImageTo(textField: passwordTextField, andImage: passwordlImage!)
        
        passwordlImageRight.image = UIImage(systemName: "eye.slash")
        addRightImageTo(txtField: passwordTextField, andImage: passwordlImageRight)
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        passwordlImageRight.isUserInteractionEnabled = true
        passwordlImageRight.addGestureRecognizer(tapGestureRecognizer)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        userTextField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.delegate = self
        userTextField.delegate = self
        
        self.isModalInPresentation = true
    }
    
    @ objc
    private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        
        if iconClick {
            iconClick =  false
            tappedImage?.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage?.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    private func validateField(input: UITextField, type: Field) {
        switch type {
        case .email:
            if !input.isEmail() {
                self.invalidFieldUI(input)
                self.emailValidLabel.text = "O e-mail é inválido"
                return
            }
            if !self.defaultValidate(input: input, type: type, label: self.emailValidLabel, min: 3) {
                return
            }
        case .password:
            if !input.isPasswordValid() {
                self.invalidFieldUI(input)
                self.passwordValidLabel.text = "O password deve conter letras maiúscula e minúscula, número e caracter especial"
                return
            }
            if !self.defaultValidate(input: input, type: type, label: self.passwordValidLabel, min: 5) {
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
        self.userTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    private func validFieldUI() {
        self.invalid = false
        self.emailValidLabel.text = ""
        self.passwordValidLabel.text = ""
    }
    
    private func invalidFieldUI(_ input: UITextField) {
        input.invalidField()
        self.invalid = true
    }
    
    private func proceedToHome() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "HomeViewController")
                as? HomeViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func alert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: LoginControllerProtocol {    
    func sucess() {
        self.invalid = false
        self.dismiss(animated: true, completion: nil)
        self.proceedToHome()
    }
    
    func failure(error: String) {
        self.invalid = true
        self.alert(title: "Erro", message: error)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let identifier = textField.accessibilityIdentifier else { return true }

        switch identifier {
        case Field.email.rawValue:
            self.passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let identifier = textField.accessibilityIdentifier else { return }

        switch identifier {
        case Field.email.rawValue:
            self.validateField(input: textField, type: .email)

        case Field.password.rawValue:
            self.validateField(input: textField, type: .password)

        default:
            break
        }
    }
}

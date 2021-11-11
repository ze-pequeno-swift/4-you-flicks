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
    
    // MARK: - Private Properties
    
    private let passwordlImageRight = UIImageView()
    private var iconClick = false
    private var emailGeneral = ""
    private var passwordGeneral = ""
    let controller = LoginController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoginIfNeeded()
        self.setupUI()
        self.controller.delegate = self
        navigationController?.navigationBar.isHidden = true
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
        if checkFields(email: userTextField, password: passwordTextField) {
            guard let _email = userTextField.text else { return }
            guard let _password = passwordTextField.text else { return }
            self.controller.login(email: _email, password: _password)
        }
    }
    
    func checkFields (email: UITextField, password: UITextField) -> Bool {
        guard let _email = email.text else { return false }
        guard let _password = password.text else { return false }
        
        if email.isEmpty() {
            self.alert(title: "Erro", message: "E-mail precisa ser preenchido")
            return false
        }
        
        if password.isEmpty() {
            self.alert(title: "Erro", message: "Senha precisa ser preenchido")
            return false
        }

        if !email.isEmail() {
            self.alert(title: "Erro", message: "Digite um email válido")
            return false
        }
        
        if !password.isPasswordValid() {
            self.alert(title: "Erro", message: "Senha não atende aos critérios")
            return false
        }
        
        self.emailGeneral = _email
        self.passwordGeneral = _password
        
        return true
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
        self.dismiss(animated: true, completion: nil)
        self.proceedToHome()
    }
    
    func failure(error: String) {
        self.alert(title: "Error", message: error)
    }
}

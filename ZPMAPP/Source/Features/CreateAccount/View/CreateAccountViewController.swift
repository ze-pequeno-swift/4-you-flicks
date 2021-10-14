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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    // MARK: - Vars
    let controller = CreateAccountController()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
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
        
        emailConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    // MARK: - Actions
    @IBAction func signUp(_ sender: UIButton) {
        
        let name: String = controller.returnString(campo: nameTextField.text)
        let email: String = controller.returnString(campo: emailTextField.text)
        let emailConfirmation: String = controller.returnString(campo: emailConfirmationTextField.text)
        let password: String = controller.returnString(campo: passwordTextField.text)
        let passwordConfirmation: String = controller.returnString(campo: passwordConfirmationTextField.text)
        
        controller.basic(name: name, email: email, emailConf: emailConfirmation, password: password, passwordConf: passwordConfirmation)
        
        
    }

}

extension CreateAccountViewController: CreateAccountControllerProtocol {
    
    func showAlert() {
        self.present(controller.showAlert(title: controller.titleAlert, message: controller.messageAlert), animated: true, completion: nil)
    }
    
    func sucess() {
        self.dismiss(animated: true, completion: nil)
    }
}

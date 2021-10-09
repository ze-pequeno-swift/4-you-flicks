//
//  LoginViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 23/08/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    // MARK: - Private Properties
    
    private let passwordlImageRight = UIImageView()
    private var iconClick = false
    private var emailGeneral = ""
    private var passwordGeneral = ""
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private Functions
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if checkFields(email: userTextField, password: passwordTextField) {
            Auth.auth().signIn(withEmail: emailGeneral, password: passwordGeneral) { [weak self] authResult, error in
                if error != nil {
                    print("Erro no login")
                } else {
                    self!.close()
                }
              guard let strongSelf = self else { return }
                
            }
        }
    }
    
    func checkFields (email: UITextField, password: UITextField) -> Bool {
        if let emailCheck = email.text {
            if isValidEmail(emailCheck) {
                emailGeneral = emailCheck
                if let passwordCheck = password.text {
                    passwordGeneral = passwordCheck
                    return true
                } else {
                    print("Erro na senha")
                    return false
                }
            } else {
                print("Digite um email válido")
                return false
            }
        } else {
            print("Erro no email")
            return false
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
        userTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    @ objc
    private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick {
            iconClick =  false
            tappedImage.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    private func proceedToHome() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "HomeViewController")
                as? HomeViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

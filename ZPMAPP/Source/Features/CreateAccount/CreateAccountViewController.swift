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
    
    @IBOutlet weak var nameTextFiled: UITextField!
    
    @IBOutlet weak var emailTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        let personImage = UIImage(systemName: "person")
        addLeftImageTo(textField: nameTextFiled, andImage: personImage!)
        
        let emailImage = UIImage(systemName: "mail")
        addLeftImageTo(textField: emailTextFiled, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "lock")
        addLeftImageTo(textField: passwordTextField, andImage: passwordlImage!)
        
        nameTextFiled.attributedPlaceholder = NSAttributedString(string: "Nome Completo",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        emailTextFiled.attributedPlaceholder = NSAttributedString(string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
}

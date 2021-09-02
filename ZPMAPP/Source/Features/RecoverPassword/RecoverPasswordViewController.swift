//
//  AlterarSenhaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class RecoverPasswordViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Private Properties
    
    private let passwordlImageRight = UIImageView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        let passwordlImage = UIImage(systemName: "mail")
        addLeftImageTo(textField: emailTextField, andImage: passwordlImage!)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email cadastrado",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
}

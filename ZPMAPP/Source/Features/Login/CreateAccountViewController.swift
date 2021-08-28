//
//  CriarContaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    let _SAImage = SAImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        let personImage = UIImage(systemName: "person")
        _SAImage.addLeftImageTo(txtField: nameTextFiled, andImage: personImage!)
        
        let emailImage = UIImage(systemName: "mail")
        _SAImage.addLeftImageTo(txtField: emailTextFiled, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "lock")
        _SAImage.addLeftImageTo(txtField: passwordTextFiled, andImage: passwordlImage!)
        
        //Change the PlaceHolders
        nameTextFiled.attributedPlaceholder = NSAttributedString(string: "Nome Completo", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextFiled.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextFiled.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
}

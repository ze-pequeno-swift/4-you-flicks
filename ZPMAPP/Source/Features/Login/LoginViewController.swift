//
//  LoginViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 23/08/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    
    let _SAImage = SAImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emailImage = UIImage(systemName: "mail")
        _SAImage.addLeftImageTo(txtField: txtUser, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "lock")
        _SAImage.addLeftImageTo(txtField: txtPassword, andImage: passwordlImage!)
        
        
        txtPassword.attributedPlaceholder = NSAttributedString(string:"Senha", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        txtUser.attributedPlaceholder = NSAttributedString(string:"Usuário", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
    
    }
    
}

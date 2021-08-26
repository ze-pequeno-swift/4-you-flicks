//
//  CriarContaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let _SAImage = SAImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let personImage = UIImage(systemName: "person")
        _SAImage.addLeftImageTo(txtField: txtName, andImage: personImage!)
        
        let emailImage = UIImage(systemName: "mail")
        _SAImage.addLeftImageTo(txtField: txtEmail, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "eye")
        _SAImage.addLeftImageTo(txtField: txtPassword, andImage: passwordlImage!)

        txtName.attributedPlaceholder = NSAttributedString(string:"Nome Completo", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        txtEmail.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        txtPassword.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        
    }

}

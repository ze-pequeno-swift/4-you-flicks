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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let emailImage = UIImage(systemName: "mail")
        addLeftImageTo(txtField: txtUser, andImage: emailImage!)
        
    
    }
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y:0.0, width: img.size.width, height: img.size.height))
        
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
        
    }
    
}

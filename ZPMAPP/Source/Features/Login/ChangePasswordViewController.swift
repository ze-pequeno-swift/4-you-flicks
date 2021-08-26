//
//  AlterarSenhaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtRenterNewPassword: UITextField!
    
    let _SAImage = SAImage()
    let passwordlImageRight = UIImageView()
    var iconClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let passwordlImage = UIImage(systemName: "lock")
        _SAImage.addLeftImageTo(txtField: txtCurrentPassword, andImage: passwordlImage!)
        
        let newPasswordlImage = UIImage(systemName: "lock")
        _SAImage.addLeftImageTo(txtField: txtNewPassword, andImage: newPasswordlImage!)
        
        let reEnterNewPasswordlImage = UIImage(systemName: "lock")
        _SAImage.addLeftImageTo(txtField: txtRenterNewPassword, andImage: reEnterNewPasswordlImage!)
        

        
        //Change the PlaceHolders
        txtCurrentPassword.attributedPlaceholder = NSAttributedString(string:"Senha Atual", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        txtNewPassword.attributedPlaceholder = NSAttributedString(string:"Nova Senha", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        txtRenterNewPassword.attributedPlaceholder = NSAttributedString(string:"Nova Senha", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])

    }
    
}

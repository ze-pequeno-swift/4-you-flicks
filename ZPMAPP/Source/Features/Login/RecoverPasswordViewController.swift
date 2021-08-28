//
//  AlterarSenhaViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class RecoverPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    let _SAImage = SAImage()
    let passwordlImageRight = UIImageView()
    var iconClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        let passwordlImage = UIImage(systemName: "mail")
        _SAImage.addLeftImageTo(txtField: txtEmail, andImage: passwordlImage!)
        
        //Change the PlaceHolders
        txtEmail.attributedPlaceholder = NSAttributedString(string:"Email cadastrado", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        
    }
}

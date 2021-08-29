//
//  LoginViewController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 23/08/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    let _SAImage = SAImage()
    let passwordlImageRight = UIImageView()
    var iconClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupUI()
        navigationController?.navigationBar.isHidden = true
        //Hide tabBar
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        close()
    }
    
    func setupUI() {
        let emailImage = UIImage(systemName: "mail")
        _SAImage.addLeftImageTo(txtField: userTextField, andImage: emailImage!)
        
        let passwordlImage = UIImage(systemName: "lock")
        _SAImage.addLeftImageTo(txtField: passwordTextField, andImage: passwordlImage!)
        
        //Call FUNC to setup the icon into textField Password
        passwordlImageRight.image = UIImage(systemName: "eye.slash")
        _SAImage.addRightImageTo(txtField: passwordTextField, andImage: passwordlImageRight)
        
        // Add TapGestureReconizer at button eye of the Passowrd
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer
                                                            :)))
        passwordlImageRight.isUserInteractionEnabled = true
        passwordlImageRight.addGestureRecognizer(tapGestureRecognizer)
        
        //Change the PlaceHolders
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Senha", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
        userTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    //Func to change the icon of texfield Password
    @ objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {

        let tappedImage = tapGestureRecognizer.view as! UIImageView

        if iconClick {
            iconClick =  false
            tappedImage.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = false

        }else {
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

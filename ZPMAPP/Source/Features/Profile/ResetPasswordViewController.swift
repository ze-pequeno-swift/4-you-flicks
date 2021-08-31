//
//  ResetPasswordViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var stepFirstValidationView: UIView!
    @IBOutlet weak var stepSecondValidationView: UIView!
    @IBOutlet weak var stepThirdValidationView: UIView!
    @IBOutlet weak var checkFirstValidationView: UIImageView!
    @IBOutlet weak var checkSecondValidationView: UIImageView!
    @IBOutlet weak var checkThirdValidationView: UIImageView!
    @IBOutlet weak var updatePasswordButton: UIButton!
    @IBOutlet weak var cancelUpdatePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tappedUpdateButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func tappedCancelUpdatePasswordAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

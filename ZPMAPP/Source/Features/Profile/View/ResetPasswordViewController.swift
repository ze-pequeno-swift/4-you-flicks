//
//  ResetPasswordViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var oldPasswordTextField: UITextField!
    @IBOutlet weak private var newPasswordTextField: UITextField!
    @IBOutlet weak private var stepFirstValidationView: UIView!
    @IBOutlet weak private var stepSecondValidationView: UIView!
    @IBOutlet weak private var stepThirdValidationView: UIView!
    @IBOutlet weak private var checkFirstValidationView: UIImageView!
    @IBOutlet weak private var checkSecondValidationView: UIImageView!
    @IBOutlet weak private var checkThirdValidationView: UIImageView!
    @IBOutlet weak private var updatePasswordButton: UIButton!
    @IBOutlet weak private var cancelUpdatePasswordButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    @IBAction private func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func tappedUpdateButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func tappedCancelUpdatePasswordAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

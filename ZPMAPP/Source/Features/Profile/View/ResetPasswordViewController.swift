//
//  ResetPasswordViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    var controller: ResetController?
    var invalid: Bool = false
    
    // MARK: - IBOutlet
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var oldPasswordTextField: UITextField!
    @IBOutlet weak private var oldPasswordValidMessage: UILabel!
    @IBOutlet weak private var newPasswordTextField: UITextField!
    @IBOutlet weak private var stepFirstValidationView: UIView!
    @IBOutlet weak private var stepSecondValidationView: UIView!
    @IBOutlet weak private var stepThirdValidationView: UIView!
    @IBOutlet weak private var checkFirstValidationView: UIImageView!
    @IBOutlet weak private var checkSecondValidationView: UIImageView!
    @IBOutlet weak private var checkThirdValidationView: UIImageView!
    @IBOutlet weak private var updatePasswordButton: UIButton!
    @IBOutlet weak private var cancelUpdatePasswordButton: UIButton!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        self.setupUI()
        self.controller?.delegate = self
        hideLoading()
    }

    // MARK: - Actions
    @IBAction private func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func tappedUpdateButtonAction(_ sender: UIButton) {
        if self.invalid {
            self.alert(title: "Erro", message: "Não é possível salvar os dados com campos inválidos")
            return
        }

        let password = self.newPasswordTextField.text ?? ""
        let oldPassword = self.oldPasswordTextField.text ?? ""
        self.controller?.resetPassword(password: password, oldPassword: oldPassword)
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func tappedCancelUpdatePasswordAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func tappedRecoverPasswordAction(_ sender: Any) {
        self.controller?.recoveryPassword()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        self.newPasswordTextField.delegate = self
        self.oldPasswordTextField.delegate = self
    }
    
    private func validateField(input: UITextField) {
        if input.accessibilityIdentifier == "oldPassword" {
            if input.isEmpty() {
                input.invalidField()
                self.oldPasswordValidMessage.text = "O campo não pode ficar em branco"
                return
            } else {
                input.validField()
            }
            
            if !input.min(qty: 5) {
                input.invalidField()
                self.oldPasswordValidMessage.text = "Sua senha anterior não possui menos de 5 caracteres - clique em \"Esqueci minha senha\" para recuperar"
                return
            }

            input.validField()
            self.oldPasswordValidMessage.text = ""
            return
        }

        if input.isEmpty() {
            self.invalidFieldUI(input, step: 1)
            return
        } else {
            self.checkFirstValidationView.tintColor = UIColor.green
        }

        if !input.min(qty: 5) {
            self.invalidFieldUI(input, step: 2)
            return
        } else {
            self.checkSecondValidationView.tintColor = UIColor.green
        }
        
        if !input.isPasswordValid() {
            self.invalidFieldUI(input, step: 3)
            return
        } else {
            self.checkThirdValidationView.tintColor = UIColor.green
        }
        
        input.validField()
        self.invalid = false
    }
    
    private func invalidFieldUI(_ input: UITextField, step: Int) {
        input.invalidField()
        
        self.stepFirstValidationView.tintColor = UIColor.white
        self.stepSecondValidationView.tintColor = UIColor.white
        self.stepThirdValidationView.tintColor = UIColor.white
        self.checkFirstValidationView.tintColor = UIColor.white
        self.checkSecondValidationView.tintColor = UIColor.white
        self.checkThirdValidationView.tintColor = UIColor.white
        
        switch step {
        case 1:
            self.stepFirstValidationView.tintColor = UIColor.red
            self.checkFirstValidationView.tintColor = UIColor.red
            self.checkSecondValidationView.tintColor = UIColor.red
            self.checkThirdValidationView.tintColor = UIColor.red
        case 2:
            self.stepFirstValidationView.tintColor = UIColor.red
            self.stepSecondValidationView.tintColor = UIColor.red
            self.checkSecondValidationView.tintColor = UIColor.red
            self.checkThirdValidationView.tintColor = UIColor.red
        case 3:
            self.stepFirstValidationView.tintColor = UIColor.red
            self.stepSecondValidationView.tintColor = UIColor.red
            self.stepThirdValidationView.tintColor = UIColor.red
            self.checkThirdValidationView.tintColor = UIColor.red
        default:
            break
        }
        
        self.invalid = true
    }
    
    private func alert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ResetPasswordViewController: UITextFieldDelegate, ResetControllerProtocol {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateField(input: textField)
    }
    
    func sendRecoveryPassword() {
        self.alert(title: "Recuperação de senha", message: "Um email foi enviado para você realizar sua recuperação de senha")
    }
    
    func sendErrorRecoveryPassword() {
        self.alert(title: "Erro", message: "Não foi possível enviar um email para recuperação de senha")
    }
}

//
//  EditProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit
import PhotosUI

enum Field: String {
    case name
    case email
    case confirmEmail
    case password
    case confirmPassword
    case username
    case oldPassword
}

class EditProfileViewController: UIViewController {
    
    var controller: EditController?
    var invalid: Bool = false
    var permitionCam: Bool = false
    private var customer: Customer?

    // MARK: - IBOutlet
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak private var editAvatarButton: UIButton!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var nameValidMessageLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var emailValidMessageLabel: UILabel!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var usernameValidMessageLabel: UILabel!
    @IBOutlet weak private var saveProfileButton: UIButton!
    @IBOutlet weak private var signOutButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        self.setupUI()
        self.setCustomerData()
        hideLoading()
    }
    
    // MARK: - Actions
    @IBAction private func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func tappedSaveButtonAction(_ sender: UIButton) {
            if self.invalid {
                self.alert(title: "Erro", message: "Não é possível salvar os dados com campos inválidos")
                return
            }

            let name = self.nameTextField.text ?? ""
            let email = self.emailTextField.text ?? ""
            let username = self.usernameTextField.text ?? ""
            
            self.controller?.updateCustomer(
                name: name,
                username: username,
                email: email
            )

            self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func tappedSignOutAction(_ sender: UIButton) {
        navigationController?.navigationBar.isHidden = true
        self.controller?.signOut()
        self.proceedToLogin()
    }

    @IBAction private func tappedEditAvatarAction(_ sender: UIButton) {
        // permissions in parts
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                showUI(for: status)
            }
        }

        let alert: UIAlertController = UIAlertController.init(title: "Alterar foto de perfil", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Camera", style: UIAlertAction.Style.default, handler: { action in
            print("clicked in camera")
        }))

        alert.addAction(UIAlertAction.init(title: "Biblioteca", style: UIAlertAction.Style.default, handler: { action in
            print("Library")
            self.getImages(fromSourceType: .photoLibrary)
        }))

        alert.addAction(UIAlertAction.init(title: "Cancelar", style: UIAlertAction.Style.default, handler: { action in
            print("Cancel")
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        // config ImageView
        self.avatarImageView.circleCornerImage()
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.nameTextField.delegate = self
    }
    
    private func setCustomerData() {
        self.customer = self.controller?.getCustomer()
        self.nameTextField.text = self.customer?.name ?? ""
        self.emailTextField.text = self.customer?.email ?? ""
        self.usernameTextField.text = self.customer?.username ?? ""
        
        if let avatar = self.customer?.avatar {
            self.avatarImageView.load(url: avatar)
        }
    }
    
    private func proceedToLogin() {
        let identifier = String(describing: LoginViewController.self)
        let homeController = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: identifier)
                as? LoginViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: true)
    }
    
    private func showUI(for status: PHAuthorizationStatus) {
        switch status {
        case .authorized:
            self.permitionCam = true
        default:
            break
        }
    }
    
    private func getImages(fromSourceType: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(fromSourceType) {
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = fromSourceType
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    private func validateField(input: UITextField, type: Field) {
        switch type {
        case .email:
            if !input.isEmail() {
                self.invalidFieldUI(input)
                self.emailValidMessageLabel.text = "O e-mail é inválido"
                return
            }
        case .username:
            let validFormat = self.controller?.validUsername(value: input.text) ?? false
            if !validFormat {
                self.invalidFieldUI(input)
                self.usernameValidMessageLabel.text = "O username não possui @ como primeiro caracter"
                return
            }
        default:
            if input.isEmpty() {
                self.invalidFieldUI(input)
                self.nameValidMessageLabel.text = "O \(type.rawValue) não pode ficar em branco"
                return
            }
            if !input.min(qty: 3) {
                self.invalidFieldUI(input)
                self.nameValidMessageLabel.text = "Precisa ter pelo menos 3 caracteres no campo\(type.rawValue)"
                return
            }
            break
        }
        
        input.validField()
        self.validFieldUI()
    }
    
    private func validFieldUI() {
        self.invalid = false
        self.nameValidMessageLabel.text = ""
        self.emailValidMessageLabel.text = ""
        self.usernameValidMessageLabel.text = ""
    }
    
    private func invalidFieldUI(_ input: UITextField) {
        input.invalidField()
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

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image: UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let imageFile = image {
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
            
            if let jpegData = imageFile.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imageURL)
                
                self.controller?.uploadAvatar(path: imageURL)
                self.avatarImageView.image = UIImage(data: jpegData)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let identifier = textField.accessibilityIdentifier else { return }
        switch identifier {
        case Field.name.rawValue:
            self.validateField(input: textField, type: .name)

        case Field.email.rawValue:
            self.validateField(input: textField, type: .email)

        case Field.password.rawValue:
            self.validateField(input: textField, type: .password)

        case Field.username.rawValue:
            self.validateField(input: textField, type: .username)
        default:
            break
        }
    }
}

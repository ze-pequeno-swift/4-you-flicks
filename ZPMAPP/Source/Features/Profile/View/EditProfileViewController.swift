//
//  EditProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit
import PhotosUI

class EditProfileViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak private var editAvatarButton: UIButton!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var saveProfileButton: UIButton!
    @IBOutlet weak private var signOutButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Actions
    @IBAction private func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func tappedSaveButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func tappedSignOutAction(_ sender: UIButton) {
        self.proceedToLogin()
    }

    @IBAction private func tappedEditAvatarAction(_ sender: UIButton) {
        //permissions in parts
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                showUI(for: status)
            }
        }

        let alert: UIAlertController = UIAlertController.init(title: "Search Images", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Camera", style: UIAlertAction.Style.default, handler: { action in
            print("clicked in camera")
        }))

        alert.addAction(UIAlertAction.init(title: "Library Photos", style: UIAlertAction.Style.default, handler: { action in
            print("Library")
            self.getImages(fromSourceType: .photoLibrary)
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            print("Cancel")
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        //config ImageView
        self.avatarImageView.circleCornerImage()
    }
    
    private func proceedToLogin() {
        let loginController = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = loginController.instantiateViewController(identifier: "LoginViewController")
                as? LoginViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showUI(for status: PHAuthorizationStatus) {
        switch status {
            case .authorized:
               print( "showFullAccessUI()")
                break
            case .limited:
                print("showLimittedAccessUI()")
                break
            case .restricted:
                print("showRestrictedAccessUI()")
                break
            case .denied:
                print("showAccessDeniedUI()")
                break
            case .notDetermined:
                print("notDetermined")
                break

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
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image: UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let imageFile = image {
            self.avatarImageView.image = imageFile
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

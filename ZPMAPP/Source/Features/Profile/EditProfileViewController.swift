//
//  EditProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit
import PhotosUI

class EditProfileViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editAvatarButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //config ImageView
        self.avatarImageView.circleCornerImage()
    }
    
    // actions
    @IBAction func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSaveButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tappedSignOutAction(_ sender: UIButton) {
        self.proceedToLogin()
    }

    @IBAction func tappedEditAvatarAction(_ sender: UIButton) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image: UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let _image = image {
            self.avatarImageView.image = _image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

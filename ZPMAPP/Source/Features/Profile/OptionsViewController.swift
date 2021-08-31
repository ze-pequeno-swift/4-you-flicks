//
//  OptionsViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class OptionsViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var changePassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //config ImageView
        self.avatarImageView.circleCornerImage()
        self.configButtonCorner(editProfileButton)
        self.configButtonCorner(changePassword)
    }

    @IBAction func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tappedEditAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EditProfileViewController", sender: nil)
    }

    @IBAction func tappedChangePasswordAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ResetPasswordViewController", sender: nil)
    }
    
    private func configButtonCorner(_ uiButtonPerson: UIButton) {
        uiButtonPerson.layer.cornerRadius = 10
    }
}

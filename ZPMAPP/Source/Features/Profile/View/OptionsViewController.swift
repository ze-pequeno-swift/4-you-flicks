//
//  OptionsViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class OptionsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var editProfileButton: UIButton!
    @IBOutlet weak private var changePassword: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    // MARK: - Actions
    @IBAction private func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func tappedEditAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EditProfileViewController", sender: nil)
    }

    @IBAction private func tappedChangePasswordAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ResetPasswordViewController", sender: nil)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        //config ImageView
        self.avatarImageView.circleCornerImage()
        self.configButtonCorner(editProfileButton)
        self.configButtonCorner(changePassword)
    }
    
    private func configButtonCorner(_ uiButtonPerson: UIButton) {
        uiButtonPerson.layer.cornerRadius = 10
    }
}

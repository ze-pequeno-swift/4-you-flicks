//
//  OptionsViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class OptionsViewController: UIViewController {
    
    var controller: OptionsController?
    
    // MARK: - IBOutlet
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var editProfileButton: UIButton!
    @IBOutlet weak private var changePassword: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        self.setupUI()
        self.setCustomerData()
        hideLoading()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let customer: Customer? = sender as? Customer
        
        switch(segue.identifier) {
        case String(describing: EditProfileViewController.self):
            let editVC: EditProfileViewController? = segue.destination as? EditProfileViewController
            editVC?.controller = EditController(customer: customer)
        case String(describing: ResetPasswordViewController.self):
            let resetVC: ResetPasswordViewController? = segue.destination as? ResetPasswordViewController
            resetVC?.controller = ResetController(customer: customer)
        default:
            break
        }
    }

    // MARK: - Actions
    @IBAction private func tappedBackButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func tappedEditAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EditProfileViewController", sender: self.controller?.getCustomer())
    }

    @IBAction private func tappedChangePasswordAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ResetPasswordViewController", sender: self.controller?.getCustomer())
    }
    
    // MARK: - Private functions
    private func setupUI() {
        // config ImageView
        self.avatarImageView.circleCornerImage()
        self.resetView.roundCornersAll(cornerRadius: 10)
        self.profileView.roundCornersAll(cornerRadius: 10)
    }
    
    private func setCustomerData() {
        guard let customer = self.controller?.getCustomer() else { return }
        self.nameLabel.text = customer.name
        
        if let avatar = customer.avatar {
            self.avatarImageView.load(url: avatar)
        }
    }
}

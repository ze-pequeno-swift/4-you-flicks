//
//  HeaderProfileTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

protocol HeaderProfileProtocol: AnyObject {
    func tappedPerformSegue(identifier: String)
    func signOut()
}

class HeaderProfileTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    weak var delegate: HeaderProfileProtocol?
    
    static var identifier: String = String(describing: HeaderProfileTableViewCell.self)

    // MARK: - IBOutlet
    @IBOutlet weak private var editProfileButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak private var avatarProfileImageView: UIImageView!
    @IBOutlet weak private var nameProfileLabel: UILabel!
    @IBOutlet weak private var usernameProfileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setup(customer: Customer?) {
        if let _customer = customer {
            self.nameProfileLabel.text = _customer.name
            self.usernameProfileLabel.text = _customer.username
            
            if let avatar = _customer.avatar {
                self.avatarProfileImageView.load(url: avatar)
            }
        }
        
    }
    
    func setupUI() {
        // config ImageView
        self.avatarProfileImageView.circleCornerImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction private func tappedOptionsProfileAction(_ sender: UIButton) {
        self.delegate?.tappedPerformSegue(identifier: "OptionsViewController")
    }
    @IBAction func tappedSignOutAction(_ sender: UIButton) {
        self.delegate?.signOut()
    }
    
}

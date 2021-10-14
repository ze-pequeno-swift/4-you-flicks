//
//  HeaderProfileTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

protocol HeaderProfileProtocol: AnyObject {
    func tappedPerformSegue(identifier: String)
}

class HeaderProfileTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    weak var delegate: HeaderProfileProtocol?
    
    static var identifier: String = String(describing: HeaderProfileTableViewCell.self)

    // MARK: - IBOutlet
    @IBOutlet weak private var editProfileButton: UIButton!
    @IBOutlet weak private var notificationProfileButton: UIButton!
    @IBOutlet weak private var alertProfileButton: UIButton!
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
            
            print(_customer)
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
    
    @IBAction private func tappedNotificationAction(_ sender: UIButton) {
        print("list messages and notifications from your friends")
    }

    @IBAction private func tappedAlertAction(_ sender: UIButton) {
        print("alert, the movie you've been waiting for started in a nearby theater ")
    }
    
}

//
//  FollowersTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

class FollowersTableViewCell: UITableViewCell {
    
    static var identifier: String = String(describing: FollowersTableViewCell.self)
    
    // MARK: - IBOutlet
    @IBOutlet weak private var qtyFollowingLabel: UILabel!
    @IBOutlet weak private var qtyFollowersLabel: UILabel!
    @IBOutlet weak private var followingFollowersView: UIView!
    @IBOutlet weak private var tappedListFriendsButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        self.followingFollowersView.roundCornersAll(cornerRadius: 10)
    }
    
    func setup(following: Int, followers: Int) {
        self.qtyFollowingLabel.text = String(following)
        self.qtyFollowersLabel.text = String(followers)
    }
    
    @IBAction private func tappedFriendsAction(_ sender: Any) {
        print("Hey man! Create view to list your friends")
    }
    
}

//
//  FilterTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: FilterTableViewCell.self)
    
    // Watched
    @IBOutlet weak private var qtyWatchedLabel: UILabel!
    @IBOutlet weak private var watchedLabel: UILabel!
    @IBOutlet weak private var tappedWatchedButton: UIButton!
    @IBOutlet weak private var watchedView: UIView!
    
    // To watch
    @IBOutlet weak private var qtyWatchLabel: UILabel!
    @IBOutlet weak private var watchLabel: UILabel!
    @IBOutlet weak private var tappedWatchButton: UIButton!
    @IBOutlet weak private var watchView: UIView!
    
    // Reviews
    @IBOutlet weak private var qtyReviewsLabel: UILabel!
    @IBOutlet weak private var reviewsLabel: UILabel!
    @IBOutlet weak private var tappedReviewsButton: UIButton!
    @IBOutlet weak private var reviewsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction private func tappedWatchedAction(_ sender: UIButton) {
        print("List watched movies")
    }
    
    @IBAction private func tappedWatchAction(_ sender: UIButton) {
        print("List watch movies")
    }
    
    @IBAction private func tappedReviewsAction(_ sender: UIButton) {
        print("List reviews movies")
    }
    
}

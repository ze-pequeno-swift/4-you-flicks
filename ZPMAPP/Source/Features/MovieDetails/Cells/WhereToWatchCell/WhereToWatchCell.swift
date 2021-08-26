//
//  WhereToWatchCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class WhereToWatchCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private var cardView: UIView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: WhereToWatchCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
    }

    // MARK: - Private Functions
    
    @IBAction func whereToWatchButton(_ sender: UIButton) {
        print("Debug: Tapped Where to Watch...")
    }
}

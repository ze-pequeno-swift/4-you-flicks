//
//  SaveWatchLaterCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class SaveWatchLaterCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet private var cardView: UIView!
    
    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: SaveWatchLaterCell.self)
    }
    
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
    }
    
    // MARK: - Private functions
   
    @IBAction func traillerButton(_ sender: UIButton) {
        print("Debug: Tapped trailler...")
    }
    
    @IBAction func watchedButton(_ sender: UIButton) {
        print("Debug: Tapped watched...")
    }
    
    @IBAction func toWatchButton(_ sender: UIButton) {
        print("Debug: Tapped watch...")
    }
}

//
//  SaveWatchLaterCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

class SaveWatchLaterCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        cardView.layer.cornerRadius = 10
    }

    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: SaveWatchLaterCell.self)
    }
    
    @IBAction func traillerButton(_ sender: UIButton) {
        
    }
    
    @IBAction func watchedButton(_ sender: UIButton) {
        
    }
    
    @IBAction func toWatchButton(_ sender: UIButton) {
        
    }
    
    
}

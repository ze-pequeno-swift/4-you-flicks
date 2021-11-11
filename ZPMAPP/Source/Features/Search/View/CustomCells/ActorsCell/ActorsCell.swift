//
//  ActorsCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit

class ActorsCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var actorsNameLabel: UILabel!
    
    static var identifier: String {
        String(describing: ActorsCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public Functions
    func setupSearchActorCell(data: Movie) {
//        self.actorsNameLabel.text = data.actors
    }
}

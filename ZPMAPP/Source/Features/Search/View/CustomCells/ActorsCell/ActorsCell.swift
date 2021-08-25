//
//  ActorsCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit

class ActorsCell: UITableViewCell {

    static let identifier: String = "actorsSearchCell"

    @IBOutlet weak var actorsNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

//    func setupSearchActorCell(data: MovieList) {
//        self.actorsNameLabel.text = data.name
//    }
}

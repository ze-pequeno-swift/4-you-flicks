//
//  EmptyCollectionViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 08/11/21.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier: String = String(describing: EmptyCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        self.emptyView.roundCornersAll(cornerRadius: 10)
    }
    
    func setup(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }

}

//
//  EmptySectionCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 21/10/21.
//

import UIKit

class EmptySectionCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private  weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    // MARK: - Identifier
    static var identifier: String {
        String(describing: EmptySectionCell.self)
    }

    // MARK: - Public func
    func setupCell(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
}

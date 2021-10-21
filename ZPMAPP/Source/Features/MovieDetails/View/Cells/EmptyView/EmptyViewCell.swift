//
//  EmptyViewTableViewCell.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 21/10/21.
//

import UIKit

class EmptyViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var messageLabel: UILabel!

    @IBOutlet private weak var emptyBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }


    // MARK: - Identifier
    static var identifier: String {
        String(describing: EmptyViewCell.self)
    }

    private func configLayout() {
        emptyBackgroundView.roundCornersAll(cornerRadius: 8)
        emptyBackgroundView.layer.masksToBounds = true
    }

    // MARK: - Public func
    func setupCell(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
}

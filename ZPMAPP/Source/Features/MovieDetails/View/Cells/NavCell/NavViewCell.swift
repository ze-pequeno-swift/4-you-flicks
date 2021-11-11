//
//  NavViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 10/11/21.
//

import UIKit

protocol NavViewCellProtocol: AnyObject {
    func goBack()
}

class NavViewCell: UITableViewCell {
    
    weak var delegate: NavViewCellProtocol?
    
    static var identifier = String(describing: NavViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func backButton(_ sender: Any) {
        self.delegate?.goBack()
    }
}

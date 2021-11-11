//
//  FilterTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

protocol FilterTableViewCellProtocol: AnyObject {
    func filterMovie(tag: Tag)
}

class FilterTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: FilterTableViewCell.self)
    
    weak var delegate: FilterTableViewCellProtocol?
    
    @IBOutlet weak var watchAllView: UIView!
    @IBOutlet weak var tappedWatchAllButton: UIButton!
    
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
    
    // Watching
    @IBOutlet weak private var qtyWatchingLabel: UILabel!
    @IBOutlet weak private var watchingLabel: UILabel!
    @IBOutlet weak private var tappedWatchingButton: UIButton!
    @IBOutlet weak private var watchingView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        self.watchView.roundCornersAll(cornerRadius: 10)
        self.watchedView.roundCornersAll(cornerRadius: 10)
        self.watchingView.roundCornersAll(cornerRadius: 10)
        self.watchAllView.roundCornersAll(cornerRadius: 10)
    }
    
    func setup(watch: Int, watched: Int, watching: Int) {
        self.qtyWatchedLabel.text = String(watched)
        self.qtyWatchLabel.text = String(watch)
        self.qtyWatchingLabel.text = String(watching)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction private func tappedWatchedAction(_ sender: UIButton) {
        self.delegate?.filterMovie(tag: .watched)
    }
    
    @IBAction private func tappedWatchAction(_ sender: UIButton) {
        self.delegate?.filterMovie(tag: .watch)
    }
    
    @IBAction private func tappedWatchingAction(_ sender: UIButton) {
        self.delegate?.filterMovie(tag: .watching)
    }

    @IBAction func tappedWatchAllAction(_ sender: UIButton) {
        self.delegate?.filterMovie(tag: .all)
    }
    
}

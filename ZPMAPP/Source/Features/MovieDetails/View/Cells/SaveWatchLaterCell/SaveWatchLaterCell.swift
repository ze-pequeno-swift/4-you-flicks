//
//  SaveWatchLaterCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit

protocol SaveWatchLaterProtocol: AnyObject {
    func saveMovieDB(tag: Tag)
}

class SaveWatchLaterCell: UITableViewCell {
    
    private weak var delegate: SaveWatchLaterProtocol?
    
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
    
    func setupDelegate(delegate: SaveWatchLaterProtocol) {
        self.delegate = delegate
    }
    
    // MARK: - Private functions
   
    @IBAction func watchingButton(_ sender: UIButton) {
        self.delegate?.saveMovieDB(tag: .watching)
    }
    
    @IBAction func watchedButton(_ sender: UIButton) {
        self.delegate?.saveMovieDB(tag: .watched)
    }
    
    @IBAction func toWatchButton(_ sender: UIButton) {
        self.delegate?.saveMovieDB(tag: .watch)
    }
}

//
//  MovieCollectionViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

enum Status: String {
    case watch = "Assistir"
    case watched = "Assistiu"
    case watching = "Assistindo"
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    static let identifier: String = String(describing: MovieCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        self.movieImageView.layer.cornerRadius = 10
        self.profileImageView.circleCornerImage()
    }
    
    func setup(customer: Customer, movie: Movie, tag: Tag.RawValue) {
        if let poster = movie.posterPath {
            self.movieImageView.load(url: MovieAPI.build(image: poster, size: .original))
        }
        
        if let avatar = customer.avatar {
            self.profileImageView.load(url: avatar)
        }
        
        switch tag {
        case Tag.watch.rawValue:
            self.statusLabel.text = Status.watch.rawValue
        case Tag.watched.rawValue:
            self.statusLabel.text = Status.watched.rawValue
        case Tag.watching.rawValue:
            self.statusLabel.text = Status.watching.rawValue
        default:
            break
        }
        
    }

}

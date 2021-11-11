//
//  DetailsCell.swift
//  ZPMAPP
//
//  Created by Hellen on 25/08/21.
//

import UIKit
import CircleProgressView

class DetailsCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var backdropImage: UIImageView!
    
    @IBOutlet private var detailsView: UIView!
    
    @IBOutlet private var posterView: UIView!
    
    @IBOutlet private var posterImage: UIImageView!
    
    @IBOutlet private var titleMovie: UILabel!
    
    @IBOutlet private var timeMovie: UILabel!
    
    @IBOutlet private var genreMovie: UILabel!
    
    @IBOutlet private var score: UILabel!
    
   @IBOutlet private var circleProgressView: CircleProgressView!

    // MARK: - Public Properties
    
    static var identifier: String {
        String(describing: DetailsCell.self)
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public Functions
    
    func setupCell(_ movie: Movie, details: Details?) {
        guard let details = details else { return }
        
        if
            let posterPath = movie.posterPath,
            let backdropPath = movie.backdropPath {
            
            posterImage.load(url: MovieAPI.build(image: posterPath, size: .w500))
            backdropImage.load(url: MovieAPI.build(image: backdropPath, size: .w780))
        }
        
        titleMovie.text = movie.title
        timeMovie.text = details.duration
        genreMovie.text = details.genres
        
        let round = (movie.voteAverage * 10)
        score.text = round.formateVoteAverage()

       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          self.circleProgressView.setProgress(round / 100, animated: true)
       }
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        detailsView.layer.cornerRadius = 15
        detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        posterView.layer.cornerRadius = 8
        posterView.layer.masksToBounds = true
    }
}

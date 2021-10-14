//
//  SuggestionViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit
import CircleProgressView

class SuggestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var posterMovie: UIImageView!
    
    @IBOutlet private var genreLabel: UILabel!
    
    @IBOutlet private var yearLabel: UILabel!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    @IBOutlet private var score: UILabel!
    
    @IBOutlet private var progressView: CircleProgressView!
    
    // MARK: - Private Properties
    
    private var suggestion: [Movie] = []
    
    // MARK: - Public Properties
    
    var sortedMovie: Movie?
    
    var controllerSuggestion = ControllerSuggestion()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        collectionView.dataSource = self
        hidesBottomBarWhenPushed = true
        configureCell()
        
        let movie = controllerSuggestion.getMovie()
        posterMovie.layer.cornerRadius = 10
        
        posterMovie.load(url: MovieAPI.build(image: movie.posterPath ?? "", size: .w500))
        
        let round = (movie.voteAverage * 10)
        score.text = round.formateVoteAverage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.progressView.setProgress(round / 100, animated: true)
        }
    }
    
    private func configureCell() {
        showLoading()
        controllerSuggestion.fetchMovieDetails {
            guard let details = self.controllerSuggestion.getDetails() else { return }
            self.genreLabel.text = details.genres
            self.suggestion = details.recommendations
        }
    
        hideLoading()
    }
    
    @IBAction private func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - UITableView Protocol Extensions

extension SuggestionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestion.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = SuggestionCell.identifier

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? SuggestionCell else { return UICollectionViewCell() }

        cell.setupCell(suggestion[indexPath.item])
        
        return cell
    }
}

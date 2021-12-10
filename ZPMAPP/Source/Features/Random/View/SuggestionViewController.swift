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
        showLoginIfNeeded()
        setupUI()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        controllerSuggestion.delegate = self
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        collectionView.dataSource = self
        hidesBottomBarWhenPushed = true
        configureCell()
        
        guard let movie = controllerSuggestion.getMovie() else { return }
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
    
    private func showLoginIfNeeded() {
        if self.controllerSuggestion.userIsLogged() {
            return
        }
        proceedToLogin()
    }
    
    private func proceedToLogin() {
        let identifier = String(describing: LoginViewController.self)
        let homeController = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: identifier)
                as? LoginViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: true)
    }
    
    @IBAction private func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func alert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableView Protocol Extensions

extension SuggestionViewController: UICollectionViewDataSource, ControllerSuggestionProtocol {
    
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
    
    func failure(error: String) {
        self.alert(title: "Erro", message: error)
    }
}

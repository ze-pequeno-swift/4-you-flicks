//
//  MovieDetailsViewController.swift
//  ZPMAPP
//
//  Created by Hellen on 24/08/21.
//

import UIKit

protocol MovieDetailsViewControllerProtocol: AnyObject {

    func showMovieListError(_ errorMessage: String)
}

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private Properties
    
    var controllerMovieDetails = ControllerMovieDetails()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
        controllerMovieDetails.fetchMovieDetails()
        hideLoading()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        setupNavigationBar()
    }
    
    // MARK: - Private Functions
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.navigationStyle()
        navigationItem.backButton(target: self, action: #selector(close))
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        controllerMovieDetails.viewController = self
        
        DetailsCell.registerOn(tableView)
        SaveWatchLaterCell.registerOn(tableView)
        DescriptionCell.registerOn(tableView)
        WhereToWatchCell.registerOn(tableView)
        MoviesNearbyCell.registerOn(tableView)
        CustomCastCell.registerOn(tableView)
        RecommendationTableViewCell.registerOn(tableView)
    }
    
    private func getDetailsCell() -> UITableViewCell {
        let identifier = DetailsCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DetailsCell else { return UITableViewCell() }
        
        let movie = controllerMovieDetails.getMovie()
        let details = controllerMovieDetails.getDetails()

        cell.setupCell(movie, details: details ?? Details())
        
        return cell

    }
    
    private func getSaveWatchLaterCell() -> UITableViewCell {
        let identifier = SaveWatchLaterCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? SaveWatchLaterCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getDescriptionCell() -> UITableViewCell {
        let identifier = DescriptionCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DescriptionCell else { return UITableViewCell() }
        
        
        let movie = controllerMovieDetails.getMovie()
        cell.setupCell(movie)
        
        return cell
    }
    
    private func getWhereToWatchCell() -> UITableViewCell {
        let identifier = WhereToWatchCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? WhereToWatchCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getMoviesNearbyCell() -> UITableViewCell {
        let identifier = MoviesNearbyCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? MoviesNearbyCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getCustomCastCell() -> UITableViewCell {
        let identifier = CustomCastCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? CustomCastCell else { return UITableViewCell() }
        
        if let details = controllerMovieDetails.getDetails() {
            details.cast.isEmpty ? cell.isHidden = true : cell.setupCell(details)
        }
        return cell
    }

    private func getRecommendations() -> UITableViewCell {
        let identifier = RecommendationTableViewCell.identifier

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? RecommendationTableViewCell else {
                    return UITableViewCell()
                }
        let detail = controllerMovieDetails.getDetails()

        cell.setupCell(detail)
        return cell
    }
}

// MARK: - UITableView Protocol Extensions

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum DetailsSection: Int, CaseIterable {
        case details
        case saveWatchLater
        case description
        case whereToWatch
        case moviesNearby
        case customCast
        case recommendations
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DetailsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
            case .details:
                return getDetailsCell()
            case .saveWatchLater:
                return getSaveWatchLaterCell()
            case .description:
                return getDescriptionCell()
            case .whereToWatch:
                return getWhereToWatchCell()
            case .moviesNearby:
                return getMoviesNearbyCell()
            case .customCast:
                return getCustomCastCell()
            case .recommendations:
                return getRecommendations()
        }
    }
}

// MARK: - HomeViewControllerDelegate Extensions

extension MovieDetailsViewController: MovieDetailsViewControllerProtocol {

    func showMovieListError(_ errorMessage: String) {
        // error
    }
}

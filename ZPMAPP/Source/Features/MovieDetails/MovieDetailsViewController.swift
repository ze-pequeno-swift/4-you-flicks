//
//  MovieDetailsViewController.swift
//  ZPMAPP
//
//  Created by Hellen on 24/08/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        DetailsCell.registerOn(tableView)
        SaveWatchLaterCell.registerOn(tableView)
        DescriptionCell.registerOn(tableView)
        WhereToWatchCell.registerOn(tableView)
        MoviesNearbyCell.registerOn(tableView)
        CustomCastCell.registerOn(tableView)
        RecommendedCell.registerOn(tableView)
    }
    
    private func getDetailsCell() -> UITableViewCell {
        let identifier = DetailsCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DetailsCell else { return UITableViewCell() }
        
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
        
        return cell
    }
    
    private func getRecommendedCell() -> UITableViewCell {
        let identifier = RecommendedCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? RecommendedCell else { return UITableViewCell() }
        
        cell.delegate = self
        
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
        case recommended
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = DetailsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .details:
            return 1
        case .saveWatchLater:
            return 1
        case .description:
            return 1
        case .whereToWatch:
            return 1
        case .moviesNearby:
            return 1
        case .customCast:
            return 1
        case .recommended:
            return 1
        }
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
        case .recommended:
            return getRecommendedCell()
        }
    }
}

// MARK: - HomeViewControllerDelegate Extensions

extension MovieDetailsViewController: HomeViewControllerDelegate {
    func tappedCell() {
        print("Details >> Details ??")
    }
}

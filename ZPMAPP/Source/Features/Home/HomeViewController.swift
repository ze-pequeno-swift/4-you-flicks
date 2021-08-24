//
//  HomeViewController.swift
//  ZPMAPP
//
//  Created by Hellen on 22/08/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        PopularMoviesCell.registerOn(tableView)
        PopularSeriesCell.registerOn(tableView)
        MoviesTheatersCell.registerOn(tableView)
        RecommendedCell.registerOn(tableView)
    }
    
    private func getMoviesTheatersCellCell() -> UITableViewCell {
        let identifier = MoviesTheatersCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? MoviesTheatersCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getPopularMoviesCell() -> UITableViewCell {
        let identifier = PopularMoviesCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? PopularMoviesCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getPopularSeriesCell() -> UITableViewCell {
        let identifier = PopularSeriesCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? PopularSeriesCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getRecommendedCell() -> UITableViewCell {
        let identifier = RecommendedCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? RecommendedCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func proceedToMoviesDetails() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableView Protocol Extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum HomeSection: Int, CaseIterable {
        case movieTheater
        case popularMovies
        case popularSeries
        case recommended
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else { return 0 }
        
        switch section {
        case .movieTheater:
            return 1
        case .popularMovies:
            return 1
        case .popularSeries:
            return 1
        case .recommended:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .movieTheater:
            return getMoviesTheatersCellCell()
        case .popularMovies:
            return getPopularMoviesCell()
        case .popularSeries:
            return getPopularSeriesCell()
        case .recommended:
            return getRecommendedCell()
        }
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    
    func tappedCell() {
        proceedToMoviesDetails()
    }
}

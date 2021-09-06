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
        showLoginIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - Private Functions
    
    private func showLoginIfNeeded() {
        guard userIsLogged() else {
            return
            
        }
        proceedToLogin()
    }
    
    private func userIsLogged() -> Bool {
        return true
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.navigationStyle()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        DailyTrendingsCell.registerOn(tableView)
        TopCustomCell.registerOn(tableView)
    }
    
    private func getMoviesTheatersCellCell() -> UITableViewCell {
        let identifier = DailyTrendingsCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DailyTrendingsCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopPopularMoviesCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopPopularSeriesCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopDramaCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopComedyCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopTerrorCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopDocumentariesCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopadventureCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func getTopRomanceCustomCell() -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    private func proceedToMoviesDetails() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func proceedToLogin() {
        let homeController = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "LoginViewController")
                as? LoginViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: true)
    }
}

// MARK: - UITableView Protocol Extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum HomeSection: Int, CaseIterable {
        case dailyTrendings
        case popularMovies
        case popularSeries
        case drama
        case comedy
        case terror
        case documentaries
        case adventure
        case romance
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else { return 0 }
        
        switch section {
        case .dailyTrendings:
            return 1
        case .popularMovies:
            return 1
        case .popularSeries:
            return 1
        case .drama:
            return 1
        case .comedy:
            return 1
        case .terror:
            return 1
        case .documentaries:
            return 1
        case .adventure:
            return 1
        case .romance:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .dailyTrendings:
            return getMoviesTheatersCellCell()
        case .popularMovies:
            return getTopPopularMoviesCustomCell()
        case .popularSeries:
            return getTopPopularSeriesCustomCell()
        case .drama:
            return getTopDramaCustomCell()
        case .comedy:
            return getTopComedyCustomCell()
        case .terror:
            return getTopTerrorCustomCell()
        case .documentaries:
            return getTopDocumentariesCustomCell()
        case .adventure:
            return getTopadventureCustomCell()
        case .romance:
            return getTopRomanceCustomCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let tableHeader = view as! UITableViewHeaderFooterView
        tableHeader.tintColor = UIColor.clear
        tableHeader.textLabel?.textColor = .white
        tableHeader.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleSection = ["Destaques diários", "Top 20 filmes populares", "Top 20 séries populares", "Dramático", "Rir é o melhor remédio", "Não apague as luzes", "Documentários surpreendentes", "Para se aventurar", "Hora do romance"]
        
        return titleSection[section]
    }
}

// MARK: - HomeViewControllerDelegate Extensions

extension HomeViewController: HomeViewControllerDelegate {
    
    func tappedCell() {
        proceedToMoviesDetails()
    }
}

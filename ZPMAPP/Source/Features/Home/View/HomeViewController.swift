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
    let homeController: HomeController = HomeController()
    
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
    private func getTopPopularMoviesCustomCell(value: HomeSection) -> UITableViewCell {
        let identifier = TopCustomCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? TopCustomCell else { return UITableViewCell() }
        
        cell.getData(apiPath: value)
        cell.delegate = self
        
        return cell
    }

    private func getTopTrending(value: HomeSection) -> UITableViewCell {
        let identifier = DailyTrendingsCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DailyTrendingsCell else { return UITableViewCell() }
        
        cell.getData(apiPath: value)
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return UITableViewCell () }

        switch section {
        case .topTrending:
            return getTopTrending(value: section)
        default:
            return getTopPopularMoviesCustomCell(value: section)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return homeController.getTitleSection(section: section)
    }
}

// MARK: - HomeViewControllerDelegate Extensions
extension HomeViewController: HomeViewControllerDelegate {
    
    func tappedCell() {
        proceedToMoviesDetails()
    }
}

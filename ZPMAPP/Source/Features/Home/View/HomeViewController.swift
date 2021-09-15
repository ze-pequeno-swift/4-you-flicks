//
//  HomeViewController.swift
//  ZPMAPP
//
//  Created by Hellen on 22/08/21.
//

import UIKit


class HomeViewController: UIViewController {
    
    let path: [LayoutSectionItemsTuple] = [
        ("trending/all/week", "Os mais assistidos da semana", .topTrending),
        ("movie/popular",     "Filmes Popular",              .popularMovies),
        ("tv/popular",        "Series Popular",              .popularSeries)
    ]

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
    
    typealias LayoutSectionItemsTuple = (apiPah: String, header: String, layout: HomeSection)
    
    enum HomeSection: Int, CaseIterable {
        case topTrending
        case popularMovies
        case popularSeries
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // print(HomeSection[indexPath.section])
        
        
        //print("######\(HomeSection.RawValue.(indexPath.section))")
        
        
        
        let cell: DailyTrendingsCell? = tableView.dequeueReusableCell(withIdentifier: "DailyTrendingsCell", for: indexPath) as? DailyTrendingsCell
        
        return cell ?? UITableViewCell()
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Teste"
    }
    
}

// MARK: - HomeViewControllerDelegate Extensions

extension HomeViewController: HomeViewControllerDelegate {
    
    func tappedCell() {
        proceedToMoviesDetails()
    }
}

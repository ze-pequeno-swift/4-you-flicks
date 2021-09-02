//
//  SearchViewController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 23/08/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private let controller = SearchController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        registerTableView()
        setupSearchBar()
        tableView.tableFooterView = UIView()
        controller.delegate(delegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }
    
    // MARK: - Private Functions
    
    private func configureDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerTableView() {
        MovieSearchCell.registerOn(tableView)
        ActorsCell.registerOn(tableView)
    }
    private func setupNavigationBar() {
        navigationController?.navigationBar.navigationStyle()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(
            x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Títulos", "Atores"]
        searchBar.delegate = self
        searchBar.selectedScopeButtonIndex = 0
        
        self.tableView.tableHeaderView = searchBar
        self.configureLayoutSearchBar(searchBar: searchBar)
        self.configLayoutScopeBar()
    }
    
    private func configureLayoutSearchBar(searchBar: UISearchBar) {
        let textPlaceholder: String = "O que está procurando?"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .customDarkGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.placeholder = textPlaceholder
    }
    
    private func configLayoutScopeBar() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .customRed
        UISegmentedControl.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    private func getActorCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ActorsCell  = tableView.dequeueReusableCell(withIdentifier: ActorsCell.identifier) as? ActorsCell else { return  UITableViewCell() }
        let customCell = self.controller.loadCustomActorsCell(indexPath: indexPath)
        
        cell.setupSearchActorCell(data: customCell)
        
        return cell
    }
    
    private func getMovieSearchCell(indexPath: IndexPath) -> UITableViewCell {
        let identifier =  MovieSearchCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? MovieSearchCell else { return  UITableViewCell() }
        let customMovieCell = controller.loadCustomFilmCell(indexPath: indexPath)
        
        cell.setupSearchMovieCell(data: customMovieCell)
        
        return cell
    }

    private func proceedToMovie() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else { return }

        self.present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate Protocol

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.controller.searchMovieResults(searchText: searchText, index: searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableView Protocol Extensions

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.resultCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        controller.checkFilmEmptyState()
            ? getActorCell(indexPath: indexPath)
            : getMovieSearchCell(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = selectedScopeBar(rawValue: indexPath.item) else { return }

        switch section.rawValue {
            case 1:
                performSegue(withIdentifier: "ActorsDetailViewController", sender: nil)
            default:
                proceedToMovie()
        }
    }
}

extension SearchViewController: SearchControllerProtocol {
    func reloadActorsData() {
        self.tableView.reloadData()
    }

    func reloadFilmData() {
        self.tableView.reloadData()
    }
}

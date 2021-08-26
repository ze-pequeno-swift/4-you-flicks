//
//  SearchViewController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 23/08/21.
//

import UIKit


class SearchViewController: UIViewController {
    @IBOutlet private weak var searchTableView: UITableView!

    private let controller = SearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDelegate()
        self.registerTableView()
        self.searchTableView.tableFooterView = UIView()
        self.configSearchBar()
    }

    private func configDelegate() {
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
    }

    private func registerTableView() {
        self.searchTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.identifier)
        self.searchTableView.register(UINib(nibName: "ActorsCell", bundle: nil), forCellReuseIdentifier: ActorsCell.identifier)
    }

    private func configSearchBar() {
        let  searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Títulos", "Atores", "Usuários"]
        searchBar.delegate = self
        
        self.searchTableView.tableHeaderView = searchBar
        self.configLayoutSearchBar(searchBar: searchBar)
        self.configLayoutScopeBar()
    }

    private func configLayoutSearchBar(searchBar: UISearchBar) {
        let textPlaceholder: String = "O que está procurando?"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .customDarkGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.placeholder = textPlaceholder
    }

    private func configLayoutScopeBar() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .customRed
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.controller.searchMovieResults(searchText: searchText, index: searchBar.selectedScopeButtonIndex)
        self.searchTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.resultCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if controller.checkFilmEmptyState() {
            guard let cell: ActorsCell  = searchTableView.dequeueReusableCell(withIdentifier: ActorsCell.identifier) as? ActorsCell else { return  UITableViewCell() }
            let customCell = self.controller.loadCustomActorsCell(indexPath: indexPath)

            cell.setupSearchActorCell(data: customCell)
            return cell

        } else {
            guard let cell: MovieCell  = searchTableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else { return  UITableViewCell() }
            let customCell = self.controller.loadCustomFilmCell(indexPath: indexPath)

            cell.setupSearchMovieCell(data: customCell)
            return cell
        }
    }
}


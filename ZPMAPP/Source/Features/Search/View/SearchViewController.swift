//
//  SearchViewController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 23/08/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private let controller = SearchController()

    var search = UISearchController(searchResultsController: nil)
    var searching = false
    var searchSegmentedControlTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDelegate()
        self.registerTableView()
        self.searchTableView.tableFooterView = UIView()
    }
    
    @IBAction func tappedCancelButton(_ sender: UIButton) {
    }


    private func configDelegate() {
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
        self.searchBar.delegate = self
    }

    private func registerTableView() {
        self.searchTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.identifier)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieCell  = searchTableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else { return  UITableViewCell() }

        let customCell = self.controller.loadCustomCell(indexPath: indexPath)

        cell.setupSearchMovieCell(data: customCell)
        return cell
    }
}







//        self.setupLayoutSegmentedControl()
//        self.setupTitlesSegmentedControl(firsSegment: "Títulos", secondSegment: "Atores", thirdSegment: "Usuários")



//    private func setupTableViewCell() -> UITableViewCell {
//        guard let cell: MovieCell  = searchTableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else { return  UITableViewCell() }
//
//        return cell
//    }

//    private func setupLayoutSegmentedControl() {
//        self.searchSegmentedControl.backgroundColor = .customDarkGray
//        self.searchSegmentedControl.selectedSegmentTintColor = .customRed
//        self.searchSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
//    }
//
//    private func setupTitlesSegmentedControl(firsSegment: String,secondSegment: String, thirdSegment: String) {
//        self.searchSegmentedControl.setTitle(firsSegment, forSegmentAt: 0)
//        self.searchSegmentedControl.setTitle(secondSegment, forSegmentAt: 1)
//        self.searchSegmentedControl.setTitle(thirdSegment, forSegmentAt: 2)
//    }

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
    private let searchBar = UISearchBar(frame: CGRect(
                                            x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
    private var searchSelectedMovie: Movie?
    private weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        registerTableView()
        setupSearchBar()
        tableView.tableFooterView = UIView()
        delegate = self
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
    
    private func setupSearchBar() {
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        configureLayoutSearchBar(searchBar: searchBar)
    }
    
    private func configureLayoutSearchBar(searchBar: UISearchBar) {
        let textPlaceholder: String = "O que está procurando?"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .customDarkGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .customRed
        searchBar.searchTextField.placeholder = textPlaceholder
        searchBar.tintColor = .customRed
        searchBar.searchTextField.addBackButtonOnKeyboard()

    }

    private func getMovieSearchCell(indexPath: IndexPath) -> UITableViewCell {
        let identifier =  MovieSearchCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? MovieSearchCell else { return  UITableViewCell() }
        let customMovieCell = controller.loadCustomFilmCell(indexPath: indexPath)
        
        cell.setupSearchMovieCell(data: customMovieCell)
        
        return cell
    }

    private func proceedToMoviesDetails() {
        let identifier = "MovieDetailsViewController"
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let detailMovieVC = homeController.instantiateViewController(identifier: identifier)
                as? MovieDetailsViewController else { return }

        detailMovieVC.controllerMovieDetails.movie = searchSelectedMovie
        detailMovieVC.hidesBottomBarWhenPushed = true


        navigationController?.pushViewController(detailMovieVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate Protocol

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true else {
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
        !text.isEmpty else {
            return
        }
        controller.searchMovieResults(searchText: text) { success, _ in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.showMessage(title: "Algo deu errado", message: "Não conseguimos encontrar nenhum filme")
            }
        }
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableView Protocol Extensions

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.resultCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getMovieSearchCell(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tappedCell(selectedMovie: controller.getMovieArray[indexPath.row])
        proceedToMoviesDetails()
    }
}

extension SearchViewController: HomeViewControllerDelegate {
    func tappedCell(selectedMovie: Movie?) {
        self.searchSelectedMovie = selectedMovie
    }
}

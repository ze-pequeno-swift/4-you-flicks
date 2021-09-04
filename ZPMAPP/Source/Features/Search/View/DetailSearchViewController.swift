//
//  DetailSearchViewController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 02/09/21.
//

import UIKit


class DetailSearchViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var actorSearchNameLabel: UILabel!
    @IBOutlet private weak var tableViewDetailSearch: UITableView!

    // MARK: - Public Properties
    var movieData = [MovieList]()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        registerTableView()
        setupLayout()
    }

    // MARK: - IBAction

    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Functions
    private func configureDelegate() {
        tableViewDetailSearch.dataSource = self
        tableViewDetailSearch.delegate = self
    }

    private func registerTableView() {
        MovieSearchCell.registerOn(tableViewDetailSearch)
    }

    private func setupLayout() {
        tableViewDetailSearch.backgroundColor = .black
        view.backgroundColor = .black
    }

    private func configureCustomCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewDetailSearch.dequeueReusableCell(withIdentifier: MovieSearchCell.identifier, for: indexPath) as? MovieSearchCell
        cell?.setupSearchMovieCell(data: movieData[indexPath.row])

        actorSearchNameLabel.text = movieData[indexPath.row].actors

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableView Protocol Extensions

extension DetailSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCustomCell(indexPath: indexPath)
    }

}

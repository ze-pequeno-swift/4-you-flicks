//
//  SearchViewController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 23/08/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableViewCell()

//        self.setupLayoutSegmentedControl()
//        self.setupTitlesSegmentedControl(firsSegment: "Títulos", secondSegment: "Atores", thirdSegment: "Usuários")
    }
    private func configTableViewCell() {
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self

        self.searchTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.identifier)
    }

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
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieCell  = searchTableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else { return  UITableViewCell() }

        return cell
    }
}

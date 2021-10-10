//
//  ProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self

        HeaderProfileTableViewCell.registerOn(profileTableView)
        FilterTableViewCell.registerOn(profileTableView)
        FollowersTableViewCell.registerOn(profileTableView)
        ListMoviesTableViewCell.registerOn(profileTableView)
    }
    
    func getHeaderCell() -> UITableViewCell {
        let identifier = HeaderProfileTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? HeaderProfileTableViewCell

        cell?.delegate = self

        return cell ?? UITableViewCell()
    }
    
    func getFilterCell() -> UITableViewCell {
        let identifier = FilterTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? FilterTableViewCell ?? UITableViewCell()
        
        return cell
    }
    
    func getFollowersCell() -> UITableViewCell {
        let identifier = FollowersTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? FollowersTableViewCell ?? UITableViewCell()
        
        return cell
    }
    
    func getMovieCell() -> UITableViewCell {
        let identifier = ListMoviesTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? ListMoviesTableViewCell ?? UITableViewCell()
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    enum ProfileSection: Int, CaseIterable {
        case header
        case followers
        case filter
        case movies
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
            case .header:
                return getHeaderCell()
            case .followers:
                return getFollowersCell()
            case .filter:
                return getFilterCell()
            case .movies:
                return getMovieCell()
        }
    }
}

extension ProfileViewController: HeaderProfileProtocol {
    func tappedPerformSegue(identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
}

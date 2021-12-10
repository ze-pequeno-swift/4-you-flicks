//
//  ProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    static var identifier = String(describing: ProfileViewController.self)
    
    var controller: ProfileController!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controller = ProfileController()
        self.controller.delegate = self
        self.setupUI()
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
        self.showLoginIfNeeded()
        self.controller.getCustomerInfo()
        self.profileTableView.reloadData()
        hideLoading()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let optionVC: OptionsViewController? = segue.destination as? OptionsViewController
        let customer: Customer? = sender as? Customer
        optionVC?.controller = OptionsController(customer: customer)
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
    
    private func showLoginIfNeeded() {
        if self.controller.userIsLogged() {
            return
        }
        self.proceedToHome()
    }
    
    private func getHeaderCell() -> UITableViewCell {
        let identifier = HeaderProfileTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? HeaderProfileTableViewCell

        cell?.delegate = self
        cell?.setup(customer: self.controller.getCustomer())

        return cell ?? UITableViewCell()
    }
    
    private func getFilterCell() -> UITableViewCell {
        let identifier = FilterTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? FilterTableViewCell
        
        let contWatch = self.controller.countWatches(tag: .watch)
        let contWatched = self.controller.countWatches(tag: .watched)
        let contWatching = self.controller.countWatches(tag: .watching)
        
        cell?.delegate = self
        cell?.setup(watch: contWatch, watched: contWatched, watching: contWatching)
        
        return cell ?? UITableViewCell()
    }
    
    private func getFollowersCell() -> UITableViewCell {
        let identifier = FollowersTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? FollowersTableViewCell
        
        let contFollowers = self.controller.countFollowers()
        let contFollowings = self.controller.countFollowings()
        cell?.setup(following: contFollowings, followers: contFollowers)
        
        return cell ?? UITableViewCell()
    }
    
    private func getMovieCell() -> UITableViewCell {
        let identifier = ListMoviesTableViewCell.identifier
        let cell = profileTableView.dequeueReusableCell(withIdentifier: identifier) as? ListMoviesTableViewCell
        
        cell?.delegate = self
        cell?.setup(
            customer: self.controller.getCustomer(),
            myMovies: self.controller.getMyMovies()
        )
        
        return cell ?? UITableViewCell()
    }
    
    private func proceedToMovieNav(myMovie: MyMovie) {
        let identifier = String(describing: MovieDetailsViewController.self)
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: identifier) as? MovieDetailsViewController else { return }
        
        if let movie = myMovie.movie {
            viewController.controllerMovieDetails.movie = movie
            viewController.hidesBottomBarWhenPushed = true

            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func proceedToHome() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "HomeViewController")
                as? HomeViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: false)
    }
    
    private func executePerformSegue(identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: self.controller.getCustomer())
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

extension ProfileViewController: HeaderProfileProtocol, ProfileControllerProtocol, ListMoviesTableViewCellProtocol, FilterTableViewCellProtocol {
    
    func filterMovie(tag: Tag) {
        self.controller.filterMovie(tag: tag)
        self.profileTableView.reloadData()
    }
    
    func proceedToMovie(myMovie: MyMovie) {
        self.proceedToMovieNav(myMovie: myMovie)
    }
    
    func reloadTableView() {
        self.profileTableView.reloadData()
    }
    
    func tappedPerformSegue(identifier: String) {
        self.executePerformSegue(identifier: identifier)
    }
    
    func signOut() {
        self.controller.signOut()
        self.proceedToHome()
    }
}

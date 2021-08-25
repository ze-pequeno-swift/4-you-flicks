//
//  MovieDetailsViewController.swift
//  ZPMAPP
//
//  Created by Hellen on 24/08/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DetailsCell.registerOn(tableView)
        SaveWatchLaterCell.registerOn(tableView)
        DescriptionCell.registerOn(tableView)
        WhereToWatchCell.registerOn(tableView)
    }
    
    private func getDetailsCell() -> UITableViewCell {
        let identifier = DetailsCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DetailsCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getSaveWatchLaterCell() -> UITableViewCell {
        let identifier = SaveWatchLaterCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? SaveWatchLaterCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getDescriptionCell() -> UITableViewCell {
        let identifier = DescriptionCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? DescriptionCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getWhereToWatchCell() -> UITableViewCell {
        let identifier = WhereToWatchCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? WhereToWatchCell else { return UITableViewCell() }
        
        return cell
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum DetailsSection: Int, CaseIterable {
        case details
        case saveWatchLater
        case description
        case whereToWatch
//        case openMap
//        case recommendations
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = DetailsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .details:
            return 1
        case .saveWatchLater:
            return 1
        case .description:
            return 1
        case .whereToWatch:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DetailsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .details:
            return getDetailsCell()
        case .saveWatchLater:
            return getSaveWatchLaterCell()
        case .description:
            return getDescriptionCell()
        case .whereToWatch:
            return getWhereToWatchCell()
        }
    }
}

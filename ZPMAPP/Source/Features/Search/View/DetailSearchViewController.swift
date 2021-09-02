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

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBAction

    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

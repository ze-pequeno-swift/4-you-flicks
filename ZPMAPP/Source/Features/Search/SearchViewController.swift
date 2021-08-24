//
//  SearchViewController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 23/08/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayoutSegmentedControl()
        self.setupTitlesSegmentedControl(firsSegment: "Títulos", secondSegment: "Atores", thirdSegment: "Usuários")
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    private func setupLayoutSegmentedControl() {
        self.searchSegmentedControl.backgroundColor = .customDarkGray
        self.searchSegmentedControl.selectedSegmentTintColor = .customRed
        self.searchSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
    }

    private func setupTitlesSegmentedControl(firsSegment: String,secondSegment: String, thirdSegment: String) {
        self.searchSegmentedControl.setTitle(firsSegment, forSegmentAt: 0)
        self.searchSegmentedControl.setTitle(secondSegment, forSegmentAt: 1)
        self.searchSegmentedControl.setTitle(thirdSegment, forSegmentAt: 2)
    }
}

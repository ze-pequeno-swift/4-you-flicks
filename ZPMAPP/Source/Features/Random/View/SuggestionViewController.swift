//
//  SuggestionViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var principalImageView: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var rottenTomatoesPercentageLabel: UILabel!
    
    @IBOutlet weak var rottenTomatoesImageView: UIImageView!
    
    @IBOutlet weak var imdbPercentageLabel: UILabel!
    
    @IBOutlet weak var imdbImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        principalImageView.layer.cornerRadius = 10
        rottenTomatoesImageView.roundCorners(cornerRadius: 8.0, typeCorners:[.bottomRight, .bottomLeft, .topRight, .topLeft])
        imdbImageView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
    }
    
    @IBAction private func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
}

// MARK: - UITableView Protocol Extensions

extension SuggestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

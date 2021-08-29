//
//  SuggestionViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var principalImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var rottenTomatoesPercentageLabel: UILabel!
    @IBOutlet weak var rottenTomatoesImageView: UIImageView!
    @IBOutlet weak var imdbPercentageLabel: UILabel!
    @IBOutlet weak var imdbImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        RecommendedCell.registerOn(tableView)
        
        self.principalImageView.layer.cornerRadius = 10
        //self.principalImageView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft]);
        self.rottenTomatoesImageView.roundCorners(cornerRadius: 8.0, typeCorners:[.bottomRight, .bottomLeft, .topRight, .topLeft]);
        self.imdbImageView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft]);
    }
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
    
    private func getRecommendedCell() -> UITableViewCell {
        let identifier = RecommendedCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? RecommendedCell else { return UITableViewCell() }
        
        //cell.delegate = self
        
        return cell
    }
}

extension SuggestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getRecommendedCell()
    }
    
    
}

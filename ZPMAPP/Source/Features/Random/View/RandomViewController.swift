//
//  RandomViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit

class RandomViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var objectView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var chooseGenreTextField: UITextField!
    
    @IBOutlet weak var chooseNoteTextField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        headerView.roundCorners(cornerRadius: 8.0, typeCorners: [.topLeft, .topRight])
        goButton.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
        objectView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
    }

    @IBAction private func sortedMovie(_ sender: UIButton) {
        performSegue(withIdentifier: "SuggestionViewControllerSegue", sender: nil)
    }

}

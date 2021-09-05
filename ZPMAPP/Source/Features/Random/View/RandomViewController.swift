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
    
    @IBOutlet weak var optionSegmented: UISegmentedControl!
    
    @IBOutlet weak var genreButton: UIButton!
    
    @IBOutlet weak var ratingButton: UIButton!
    
    @IBOutlet weak var goButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        objectView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
        goButton.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
        
        optionSegmented.selectedSegmentTintColor = UIColor(named: "Main Red")
        optionSegmented.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
    }

    @IBAction private func drawAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SuggestionViewControllerSegue", sender: nil);
    }

    @IBAction private func genreChoices(_ sender: UIButton) {
        
    }

    @IBAction private func ratingChoices(_ sender: UIButton) {
        
    }
}

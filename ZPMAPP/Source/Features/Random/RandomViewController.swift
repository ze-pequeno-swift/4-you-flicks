//
//  RandomViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit

class RandomViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var objectView: UIView!
    @IBOutlet weak var optionSegmented: UISegmentedControl!
    @IBOutlet weak var genreButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objectView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft]);
        self.goButton.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft]);
        
        self.optionSegmented.selectedSegmentTintColor = UIColor(named: "Main Red");
        self.optionSegmented.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal);
    }
    
    //MARK:- Actions
    //Button to shuffle and present the movies
    @IBAction func drawAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SuggestionViewControllerSegue", sender: nil);
    }
    //Button to choose the genre
    @IBAction func genreChoices(_ sender: UIButton) {
        
    }
    //Button to chose the movies rating
    @IBAction func ratingChoices(_ sender: UIButton) {
        
    }
    
    
}

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
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.register(UINib(nibName: "CustomSuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomSuggestionCollectionViewCell")
        
        self.principalImageView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft]);
        self.rottenTomatoesImageView.roundCorners(cornerRadius: 8.0, typeCorners:[.bottomRight, .bottomLeft, .topRight, .topLeft]);
        self.imdbImageView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft]);
    }
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
}


extension SuggestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomSuggestionCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomSuggestionCollectionViewCell", for: indexPath) as? CustomSuggestionCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    
}

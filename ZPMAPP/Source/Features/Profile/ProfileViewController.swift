//
//  ProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var notificationProfileButton: UIButton!
    @IBOutlet weak var alertProfileButton: UIButton!
    @IBOutlet weak var avatarProfileImageView: UIImageView!
    @IBOutlet weak var nameProfileLabel: UILabel!
    @IBOutlet weak var usernameProfileLabel: UILabel!
    
    // Following and Followers
    @IBOutlet weak var qtyFollowingLabel: UILabel!
    @IBOutlet weak var qtyFollowersLabel: UILabel!
    @IBOutlet weak var followingFollowersView: UIView!
    @IBOutlet weak var tappedListFriendsButton: UIButton!
    
    // Watched
    @IBOutlet weak var qtyWatchedLabel: UILabel!
    @IBOutlet weak var watchedLabel: UILabel!
    @IBOutlet weak var tappedWatchedButton: UIButton!
    @IBOutlet weak var watchedView: UIView!
    
    // To watch
    @IBOutlet weak var qtyWatchLabel: UILabel!
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var tappedWatchButton: UIButton!
    @IBOutlet weak var watchView: UIView!
    
    // Reviews
    @IBOutlet weak var qtyReviewsLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var tappedReviewsButton: UIButton!
    @IBOutlet weak var reviewsView: UIView!
    
    // CollectionView
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //config ImageView
        self.avatarProfileImageView.circleCornerImage()
        //config background view
        self.configViewCorner(followingFollowersView)
        self.configViewCorner(watchedView)
        self.configViewCorner(watchView)
        self.configViewCorner(reviewsView)
        
        self.moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
    }
    
    // actions
    @IBAction func tappedOptionsProfileAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "OptionsViewController", sender: nil)
    }
    
    @IBAction func tappedNotificationAction(_ sender: UIButton) {
        print("list messages and notifications from your friends")
    }

    @IBAction func tappedAlertAction(_ sender: UIButton) {
        print("alert, the movie you've been waiting for started in a nearby theater ")
    }
    
    @IBAction func tappedFriendsAction(_ sender: Any) {
        print("Hey man! Create view to list your friends")
    }

    @IBAction func tappedWatchedAction(_ sender: UIButton) {
        print("List watched movies")
    }
    
    @IBAction func tappedWatchAction(_ sender: UIButton) {
        print("List watch movies")
    }
    
    @IBAction func tappedReviewsAction(_ sender: UIButton) {
        print("List reviews movies")
    }
    
    private func configViewCorner(_ uiViewPerson: UIView) {
        uiViewPerson.layer.cornerRadius = 10
    }
    
    private func proceedToMovie() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieCell: MovieCollectionViewCell? = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        
        return movieCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.proceedToMovie()
    }
}

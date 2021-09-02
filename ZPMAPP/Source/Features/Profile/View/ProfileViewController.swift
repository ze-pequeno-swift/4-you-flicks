//
//  ProfileViewController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak private var editProfileButton: UIButton!
    @IBOutlet weak private var notificationProfileButton: UIButton!
    @IBOutlet weak private var alertProfileButton: UIButton!
    @IBOutlet weak private var avatarProfileImageView: UIImageView!
    @IBOutlet weak private var nameProfileLabel: UILabel!
    @IBOutlet weak private var usernameProfileLabel: UILabel!
    
    // Following and Followers
    @IBOutlet weak private var qtyFollowingLabel: UILabel!
    @IBOutlet weak private var qtyFollowersLabel: UILabel!
    @IBOutlet weak private var followingFollowersView: UIView!
    @IBOutlet weak private var tappedListFriendsButton: UIButton!
    
    // Watched
    @IBOutlet weak private var qtyWatchedLabel: UILabel!
    @IBOutlet weak private var watchedLabel: UILabel!
    @IBOutlet weak private var tappedWatchedButton: UIButton!
    @IBOutlet weak private var watchedView: UIView!
    
    // To watch
    @IBOutlet weak private var qtyWatchLabel: UILabel!
    @IBOutlet weak private var watchLabel: UILabel!
    @IBOutlet weak private var tappedWatchButton: UIButton!
    @IBOutlet weak private var watchView: UIView!
    
    // Reviews
    @IBOutlet weak private var qtyReviewsLabel: UILabel!
    @IBOutlet weak private var reviewsLabel: UILabel!
    @IBOutlet weak private var tappedReviewsButton: UIButton!
    @IBOutlet weak private var reviewsView: UIView!
    
    // MARK: - CollectionView
    @IBOutlet weak private var moviesCollectionView: UICollectionView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Actions
    @IBAction private func tappedOptionsProfileAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "OptionsViewController", sender: nil)
    }
    
    @IBAction private func tappedNotificationAction(_ sender: UIButton) {
        print("list messages and notifications from your friends")
    }

    @IBAction private func tappedAlertAction(_ sender: UIButton) {
        print("alert, the movie you've been waiting for started in a nearby theater ")
    }
    
    @IBAction private func tappedFriendsAction(_ sender: Any) {
        print("Hey man! Create view to list your friends")
    }

    @IBAction private func tappedWatchedAction(_ sender: UIButton) {
        print("List watched movies")
    }
    
    @IBAction private func tappedWatchAction(_ sender: UIButton) {
        print("List watch movies")
    }
    
    @IBAction private func tappedReviewsAction(_ sender: UIButton) {
        print("List reviews movies")
    }
    
    // MARK: - Private functions
    private func setupUI() {
        //config ImageView
        self.avatarProfileImageView.circleCornerImage()

        //config background view
        self.configViewCorner(followingFollowersView)
        self.configViewCorner(watchedView)
        self.configViewCorner(watchView)
        self.configViewCorner(reviewsView)
        
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        
        MovieCollectionViewCell.registerOn(self.moviesCollectionView)
    }
    
    private func configViewCorner(_ uiViewPerson: UIView) {
        uiViewPerson.layer.cornerRadius = 10
    }
    
    private func proceedToMovie() {
        let homeController = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else { return }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
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

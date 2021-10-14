//
//  ProfileController.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

enum Tag: String {
    case watch
    case watched
    case watching
    case all
}

protocol ProfileControllerProtocol: AnyObject {
    func reloadTableView()
}

class ProfileController {
    var friends: Friend?
    var customer: Customer?
    var myMovies: [MyMovie]? = []
    var filterMovie: [MyMovie]? = []
    let firebase: FirebaseDataService!
    
    weak var delegate: ProfileControllerProtocol?
    
    init() {
        self.firebase = FirebaseDataService()
        self.firebase.delegate = self
    }
    
    func filterMovie(tag: Tag) {
        if tag == .all {
            self.filterMovie = []
            return
        }
        
        self.filterMovie = self.myMovies?.filter({ movie in
            return movie.tag == tag.rawValue
        })
    }
    
    func getCustomer() -> Customer? {
        return self.customer
    }
    
    func getMyMovies() -> [MyMovie]? {
        let contMovies = self.filterMovie?.count ?? 0
        
        if contMovies > 0 {
            return self.filterMovie
        }
        
        return self.myMovies
    }
    
    func countFollowers() -> Int {
        if let friend = self.friends {
            return friend.followers?.count ?? 0
        }
        
        return 0
    }
    
    func countFollowings() -> Int {
        if let friend = self.friends {
            return friend.followings?.count ?? 0
        }
        
        return 0
    }
    
    func countWatches(tag: Tag) -> Int {
        if let watched = self.myMovies {
            let movies = watched.filter { movie in
                movie.tag == tag.rawValue
            }
            return movies.count
        }
        
        return 0
    }
    
    func getCustomerInfo() {
        self.firebase.getDocumentWithId(collection: "users", id: "oSbOu3BuQkUaTtqnFqYJgBFWJvw1")
        self.firebase.getDocumentWithId(collection: "users_movies", id: "oSbOu3BuQkUaTtqnFqYJgBFWJvw1")
        self.firebase.getDocumentWithId(collection: "friends", id: "oSbOu3BuQkUaTtqnFqYJgBFWJvw1")
    }
    
    private func setCustomer() {
        self.customer = self.firebase.loadCustomer()
    }
    
    private func setMyMovies() {
        self.myMovies = self.firebase.loadMyMovies()
    }
    
    private func setFriends() {
        self.friends = self.firebase.loadFriends()
    }
    
}

extension ProfileController: FirebaseDataServiceProtocol {
    func success(_ collection: String) {
        switch(collection) {
        case "users":
            self.setCustomer()
        case "movies":
            self.setMyMovies()
        case "friends":
            self.setFriends()
        default:
            break
        }

        self.delegate?.reloadTableView()
    }
    
    func failure(error: Error?) {
        print("error")
    }
}

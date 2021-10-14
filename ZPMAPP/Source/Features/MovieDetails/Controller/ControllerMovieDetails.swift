//
//  ControllerMovieDetails.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation
import Alamofire

class ControllerMovieDetails {
    
    // MARK: - Public Properties
    
    weak var viewController: MovieDetailsViewControllerProtocol!
     
    let firebase: FirebaseDataService = FirebaseDataService()
    
    var movie: Movie?
    
    var details: Details?
    
    // MARK: - Private Properties
    
    private let movieDetailsWorker: MovieDetailsWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.movieDetailsWorker = MovieDetailsWorker()
        self.firebase.delegate = self
    }
    
    init(movieDetailsWorker: MovieDetailsWorkerProtocol) {
        self.movieDetailsWorker = movieDetailsWorker
        self.firebase.delegate = self
    }
    
    // MARK: - Public Functions

    func getMovie() -> Movie {
        return movie!
    }
    
    func saveMovieDB(tag: Tag) {
        guard var movie = self.movie else {
            return
        }

        do {
            let dictMovie = try movie.dictionary()
            let movieID = String(movie.id)
            self.firebase.addDocumentWithId(collection: "movies", id: movieID, data: dictMovie)
            let refID = self.firebase.getDocumentRefWithId(collection: "movies", id: movieID)
            self.firebase.addDocumentWithId(
                collection: "users_movies",
                id: "oSbOu3BuQkUaTtqnFqYJgBFWJvw1", // <- TODO update with uid user
                data: [
                    movieID: [tag.rawValue, refID]
                ]
            )
        } catch {
            print(error)
        }
    }
    
    func getDetails() -> Details? {
        return details
    }
    
    func fetchMovieDetails() {
        guard let movie = movie else { return }
        
        movieDetailsWorker.fetchMovieDetails(of: movie.id) { [unowned self] result in
            switch result {
            case .success(let response):
                showMovieDetails(movie, response: response)
            case .failure(_):
                // Exibir erro
                break
            }
        }
    }
    
    private func showMovieDetails(_ movie: Movie, response: MovieDetailsResponse?) {
        guard let movieDetails = response else {
            // Exibir error
            return
        }
        
        let detalhes = Details(movieDetails)
        details = detalhes
    }
}

extension ControllerMovieDetails: FirebaseDataServiceProtocol {
    func success(_ collection: String) {
        print("OK \(collection)")
    }
    
    func failure(error: Error?) {
        print(error)
    }
}

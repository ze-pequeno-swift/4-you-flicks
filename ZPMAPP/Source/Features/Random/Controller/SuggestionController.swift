//
//  SuggestionController.swift
//  ZPMAPP
//
//  Created by Hellen on 10/10/21.
//

import Foundation

class ControllerSuggestion {
    
    var movie: Movie?
    
    var details: Details?
    
    // MARK: - Private Properties
    
    private let movieDetailsWorker: MovieDetailsWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.movieDetailsWorker = MovieDetailsWorker()
    }
    
    init(movieDetailsWorker: MovieDetailsWorkerProtocol) {
        self.movieDetailsWorker = movieDetailsWorker
    }
    
    // MARK: - Public Functions

    func getMovie() -> Movie {
        return movie!

    }
    
    func getDetails() -> Details? {
        return details
    }
    
    func fetchMovieDetails(completion: @escaping () -> Void) {
        guard let movie = movie else { return }

        movieDetailsWorker.fetchMovieDetails(of: movie.id) { [unowned self] result in
            switch result {
            case .success(let response):
                showMovieDetails(movie, response: response)
                completion()
            case .failure(_):
                // Exibir erro
                break
            }
        }
    }
    
    func userIsLogged() -> Bool {
        return FirebaseDataService.userIsLoggedIn()
    }
    
    // MARK: - Private Functions
    
    private func showMovieDetails(_ movie: Movie, response: MovieDetailsResponse?) {
        guard let movieDetails = response else {
            // Exibir error
            return
        }
        
        let detalhes = Details(movieDetails)
        details = detalhes
    }
}

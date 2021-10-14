//
//  ControllerMovieDetails.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

class ControllerMovieDetails {
    
    // MARK: - Public Properties
    
    weak var viewController: MovieDetailsViewControllerProtocol!
    
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

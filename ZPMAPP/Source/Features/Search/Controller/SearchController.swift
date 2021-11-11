//
//  SearchController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import Foundation

class SearchController {
    
    // MARK: - Private Properties
    
    private var arrayMovie: [Movie] = []

    private let movieListWorker: MovieWorkerProtocol

    // MARK: - Init

    init() {
        self.movieListWorker = MovieListWorker()
    }

    // MARK: - Public Properties

    var getMovieArray: [Movie] {
        return arrayMovie
    }
    
    // MARK: - Public Functions

    func resultCount() -> Int {
        return arrayMovie.count
    }
    
    func loadCustomFilmCell(indexPath: IndexPath) -> Movie {
        return arrayMovie[indexPath.row]
    }

    func checkEmptyState() -> Bool {
        return arrayMovie.isEmpty
    }
    
    func searchMovieResults(searchText: String, completion: @escaping (Bool, Error?) -> Void) {

        movieListWorker.fetchMovieWithQuery(query: searchText.uppercased()) { [weak self] result in
            guard let self = self else { return }
            switch result {
               case .success(let response):
                    self.arrayMovie = response.results
                       completion(true, nil)
               case .failure(let error):
                   print(error)
                 break
               }
        }
    }
    
    func userIsLogged() -> Bool {
        return FirebaseDataService.userIsLoggedIn()
    }
}

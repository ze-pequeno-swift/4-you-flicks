//
//  SearchController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import Foundation

enum SelectedScopeBar: Int, CaseIterable {
    case title = 0
    case actors = 1
}

class SearchController {
    
    // MARK: - Private Properties
    
    private var arrayMovie: [Movie] = []
    
    private var arrayFilmSearchResult: [Movie] = []
    private var arrayActorsSearchResult: [Movie] = []

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
//        checkFilmEmptyState() ? arrayActorsSearchResult.count : arrayFilmSearchResult.count

        return arrayMovie.count
    }
    
    func checkFilmEmptyState() -> Bool {
        return arrayFilmSearchResult.isEmpty
    }
    
    func loadCustomFilmCell(indexPath: IndexPath) -> Movie {
        return arrayMovie[indexPath.row]
    }
    
    func loadCustomActorsCell(indexPath: IndexPath) -> Movie {
        return arrayActorsSearchResult[indexPath.row]
    }
    
    func searchMovieResults(searchText: String, completion: @escaping (Bool, Error?) -> Void) {

        movieListWorker.fetchMovieWithQuery(query: searchText.uppercased()) { [weak self] result in
            guard let self = self else { return }
            switch result {
               case .success(let response):
                    self.arrayMovie = response.results
                       completion(true, nil)
               case .failure(_):
                   // Exibir erro
                 break
               }
        }
    }
}

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
    
    private var arrayFilmSearchResult: [MovieList] = []
    private var arrayActorsSearchResult: [MovieList] = []

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
        checkFilmEmptyState() ? arrayActorsSearchResult.count : arrayFilmSearchResult.count
    }
    
    func checkFilmEmptyState() -> Bool {
        return arrayFilmSearchResult.isEmpty
    }
    
    func loadCustomFilmCell(indexPath: IndexPath) -> MovieList {
        return arrayFilmSearchResult[indexPath.row]
    }
    
    func loadCustomActorsCell(indexPath: IndexPath) -> MovieList {
        return arrayActorsSearchResult[indexPath.row]
    }
    
    func searchMovieResults(searchText: String, index: Int, completion: @escaping (Bool, Error?) -> Void) {

        movieListWorker.fetchMovieWithQuery(query: searchText.uppercased()) { [unowned self] result in
            switch result {
               case .success(let response):
                   arrayMovie = response.results
                       print(arrayMovie)
                       completion(true, nil)
               case .failure(_):
                   // Exibir erro
                 break
               }

        }

//        if searchText.isEmpty {
//            arrayFilmSearchResult = []
//            arrayActorsSearchResult = []
//        }

//            switch index {
//            case SelectedScopeBar.title.rawValue:
//                self.arrayFilmSearchResult = self.arrayMovie.filter { model -> Bool in
//                    guard let movie = model.title?.uppercased() else { return false }
//                    return movie.contains(searchText.uppercased())
//                }
//            case SelectedScopeBar.actors.rawValue:
//                self.arrayActorsSearchResult = self.arrayMovie.filter { model -> Bool in
//                    guard let movie = model.actors?.uppercased() else { return false }
//                    return movie.contains(searchText.uppercased())
//                }
//            default:
//                arrayFilmSearchResult = []
//                arrayActorsSearchResult = []
//        }
    }
}

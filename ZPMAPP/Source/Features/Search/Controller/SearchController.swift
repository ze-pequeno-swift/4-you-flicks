//
//  SearchController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import Foundation

enum selectedScopeBar: Int {
    case title = 0
    case actors = 1
}

protocol SearchControllerProtocol: AnyObject {
    func reloadActorsData()
    func reloadFilmData()
}

class SearchController {
    
    // MARK: - Private Properties
    private weak var delegate: SearchControllerProtocol?
    
    private var arrayMovie: [MovieList] = [
        MovieList(title: "Joker", image: "joker", genre: "Drama", length: "2h10m", actors: "Elizabeth Olsen"), MovieList(title: "Viúva Negra", image: "black-widow", genre: "Ação", length: "1h50", actors: "Elizabeth Banks"), MovieList(title: "Nós", image: "us", genre: "Terror", length: "2h50m", actors: "Mary Elizabeth"), MovieList(title: "Midsommar", image: "midsommar", genre: "Terror", length: "2h40m", actors: "Elizabeth Olsen"), MovieList(title: "Jaws", image: "jaws", genre: "Suspense", length: "1h50", actors: "Elizabeth Banks")
    ]
    
    private var arrayFilmSearchResult: [MovieList] = []
    private var arrayActorsSearchResult: [MovieList] = []
    
    // MARK: - Public Functions

    func delegate(delegate: SearchControllerProtocol) {
        self.delegate = delegate
    }
    
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
    
    func searchMovieResults(searchText: String, index: Int) {

        if searchText.isEmpty {
            arrayFilmSearchResult = []
            arrayActorsSearchResult = []
        }

            switch index {
            case selectedScopeBar.title.rawValue:
                self.arrayFilmSearchResult = self.arrayMovie.filter { model -> Bool in
                    guard let movie = model.title?.uppercased() else { return false }
                    return movie.contains(searchText.uppercased())
                }
            case selectedScopeBar.actors.rawValue:
                self.arrayActorsSearchResult = self.arrayMovie.filter { model -> Bool in
                    guard let movie = model.actors?.uppercased() else { return false }
                    return movie.contains(searchText.uppercased())
                }
            default:
                arrayFilmSearchResult = []
                arrayActorsSearchResult = []
        }
    }
}



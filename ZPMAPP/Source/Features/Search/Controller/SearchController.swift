//
//  SearchController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import Foundation

class SearchController {

    private var arrayMovie: [MovieList] = [
        MovieList(title: "Joker", image: "joker", genre: "Drama", length: "2h10m", actors: "Elizabeth Olsen"), MovieList(title: "Viúva Negra", image: "black-widow", genre: "Ação", length: "1h50", actors: "Elizabeth Banks"), MovieList(title: "Nós", image: "us", genre: "Terror", length: "2h50m", actors: "Mary Elizabeth"), MovieList(title: "Midsommar", image: "midsommar", genre: "Terror", length: "2h40m", actors: "Elizabeth Olsen"), MovieList(title: "Jaws", image: "jaws", genre: "Suspense", length: "1h50", actors: "Elizabeth Banks")
    ]

    private var arrayMovieSearchResult: [MovieList] = []
    private var arrayActorsSearchResult: [MovieList] = []
    private var arrayUsersSearchResult: [Users] = []

    func resultCount() -> Int {
        return self.arrayMovieSearchResult.count
        
    }

    func arrayCount() -> Int {
        return self.arrayMovie.count
    }

    func loadCustomCell(indexPath: IndexPath) -> MovieList {
        return self.arrayMovieSearchResult[indexPath.row]
    }

    func searchMovieResults(searchText: String) {
        self.arrayMovieSearchResult = []

        for movie in self.arrayMovie {
            guard let title = movie.title, let actors = movie.actors else { return }
            if title.uppercased().contains(searchText.uppercased()) {
                self.arrayMovieSearchResult.append(movie)
            } else if actors.uppercased().contains(searchText.uppercased()) {
                self.arrayActorsSearchResult.append(movie)
            }
        }
    }
}



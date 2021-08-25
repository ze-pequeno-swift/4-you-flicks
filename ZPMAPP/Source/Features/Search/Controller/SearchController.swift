//
//  SearchController.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import Foundation

class SearchController {

    private var arrayMovie: [MovieList] = [MovieList(title: "Joker", image: "joker", genre: "Drama", length: "2h10m", actors: "Elizabeth Olsen"), MovieList(title: "Viúva Negra", image: "black-widow", genre: "Ação", length: "1h50", actors: "Elizabeth Banks"), MovieList(title: "Nós", image: "us", genre: "Terror", length: "2h50m", actors: "Mary Elizabeth")]

    var searchResult = [MovieList]()

    public func count() -> Int{
        return self.arrayMovie.count
    }

    public func loadCustomCell(indexPath: IndexPath) -> MovieList {
        return self.arrayMovie[indexPath.row]
    }
}

//
//  RandomController.swift
//  ZPMAPP
//
//  Created by Hellen on 08/10/21.
//

import Foundation

protocol RandomControllerProtocol: AnyObject {
    func get(sortedMovie: Movie?)
}

class RandomController {
    
    var movieList: [Movie] = []
    
    var genreSelectedd: String?
    
    var note: Double?
    
    var sortedMovie: Movie?
    
    // MARK: - Private Properties
    
    private let movieListWorker: MovieWorkerProtocol
    
    weak var delegate: RandomControllerProtocol?
    
    // MARK: - Init
    
    init() {
        self.movieListWorker = MovieListWorker()
    }
    
    func get(note: String) {
        self.note = Double(note)
        print("==== nota é \(note)")
    }
    
//    let picker = ["Dramas": 1,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2,
//                  "Comédia": 2 ]
//
//    let pickerData = ["Dramas", "Comédia", "Filmes para família", "Romance", "Ação", "Documentários", "Terror", "Fantasia", "Animes", "Musical", "Policial"]
    
    func sotedMovie(moviesFilters: [Movie]) {
        sortedMovie = moviesFilters.randomElement()
        delegate?.get(sortedMovie: sortedMovie)
        
        print("FILME SORTADO ALEATORIAMENTE É \(sortedMovie)")
    }
    
    func filterMovie(movieList: [Movie]) {
        guard let note = note else { return }
        let moviesFilters = movieList.filter { $0.voteAverage >= note }
        
        sotedMovie(moviesFilters: moviesFilters)
    }

    func fetchRandomList(genreSelected: String) {
        let path = path.first { $0.genre == genreSelected}
        
        print("=== path \(path)")
        guard let idGenre = path?.idGenre else { return }
        print("=== path \(idGenre)")
        
        movieListWorker.fecthMovieWithGenre(section: .popular, type: .movie, idGenre: idGenre) { [unowned self] result in
            switch result {
            case .success(let response):
                movieList = response.results
                filterMovie(movieList: movieList)
            case .failure(_):
                // Exibir erro
              break
            }
        }
    }
    
    typealias SetGenreItemsPicker = (idGenre: Int, genre: String)
    
    let path: [SetGenreItemsPicker] = [
        (18, "Drama"),
        (35, "Comédia"),
        (10751, "Filmes para família"),
        (10749, "Romance")
    ]
}

extension RandomController: SelectedGenreMovie {
    
    func genreMovie(genre: String) {
        genreSelectedd = genre
    }
}

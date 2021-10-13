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
    
    var note: Double?
    
    var sortedMovie: Movie?
    
    // MARK: - Private Properties
    
    private let movieListWorker: MovieWorkerProtocol
    
    weak var delegate: RandomControllerProtocol?
    
    // MARK: - Init
    
    init() {
        self.movieListWorker = MovieListWorker()
    }
    
    // MARK: - Public Functions
    
    func get(note: String) {
        self.note = Double(note)
    }
    
    // MARK: - Private Functions
    
    func fetchRandomList(genreSelected: String, completion: @escaping () -> Void) {
        let path = self.path.first { $0.genre == genreSelected} 
        guard let idGenre = path?.idGenre else { return }

        movieListWorker.fecthMovieWithGenre(section: .popular, type: .movie, idGenre: idGenre) { [unowned self] result in
            switch result {
            case .success(let response):
                movieList = response.results
                filterMovie(movieList: movieList)
                completion()
            case .failure(_):
                // Exibir erro
              break
            }
        }
    }
    
    private func filterMovie(movieList: [Movie]) {
        guard let note = note else { return }
        let moviesFilters = movieList.filter { $0.voteAverage >= note }
        
        sotedMovie(moviesFilters: moviesFilters)
    }
    
    private func sotedMovie(moviesFilters: [Movie]) {
        sortedMovie = moviesFilters.randomElement()
        delegate?.get(sortedMovie: sortedMovie)
    }
    
    private func getSortedMovie() -> Movie? {
        return sortedMovie
    }
    
    let pickerDataGenre = ["Dramas", "Comédia", "Filmes para família", "Romance", "Ação", "Documentários", "Terror", "Fantasia", "Animes", "Musical", "Policial"]
    
    let pickerDataNote = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    typealias SetGenreItemsPicker = (idGenre: Int, genre: String)
    
    let path: [SetGenreItemsPicker] = [
        (18, "Drama"),
        (35, "Comédia"),
        (10751, "Filmes para família"),
        (10749, "Romance")
    ]
}

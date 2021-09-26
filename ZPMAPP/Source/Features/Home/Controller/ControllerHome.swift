//
//  ControllerHome.swift
//  ZPMAPP
//
//  Created by Alan Silva on 18/09/21.
//

import Foundation

class ControllerHome {
    
    // MARK: - Public Properties
    
    var movieList: [Movie] = []
    
    // MARK: - Private Properties
    
    private let movieListWorker: MovieWorkerProtocol
    
    // MARK: - Init
    
    init() {
        self.movieListWorker = MovieListWorker()
    }
    
    // MARK: - Public Functions
    
    func count() -> Int {
        return movieList.count
    }

    func getMovie(indexPath: IndexPath) -> Movie {
        return movieList[indexPath.row]
    }
    
    func getTitleSection(section: Int) -> String {
        return path[section].header
    }
    
    func fetchMovieList(value: HomeSection, completion: @escaping (Bool, Error?) -> Void) {
        let path = path.first { $0.enumHome == value }
        guard let idGenre = path?.generId else { return }

        movieListWorker.fecthMovieWithGenre(section: .popular, type: .movie, idGenre: idGenre) { [unowned self] result in
            switch result {
            case .success(let response):
                movieList = response.results
                completion(true, nil)
            case .failure(_):
                // Exibir erro
              break
            }
        }
    }
    
    func fetchDailyTrendings(value: HomeSection, completion: @escaping (Bool, Error?) -> Void) {
        movieListWorker.fetchDailyTrendings { [unowned self] result in
            switch result {
            case .success(let response):
                movieList = response.results
                completion(true, nil)
            case .failure(_):
                break
            }
        }
    }
    
    typealias SetSectionItems = (generId: Int, pathAPI: String,
                                 header: String, enumHome: HomeSection)
    
    let path: [SetSectionItems] = [
        (0,     "trending/movies/week", "Os mais assistidos da semana",  .topTrending),
        (28,    "movie/popular",     "Filmes de Ação",               .popularAction),
        (12,    "movie/popular",     "Filmes de Aventura",           .popularAdventure),
        (16,    "movie/popular",     "Filmes de Animação",           .popularAnimation),
        (35,    "movie/popular",     "Filmes de Comédia",            .popularComedy),
        (80,    "movie/popular",     "Filmes de Crime",              .popularCrime),
        (99,    "movie/popular",     "Filmes de Documentário",       .popularDocumentary),
        (18,    "movie/popular",     "Filmes de Drama",              .popularDrama),
        (10751, "movie/popular",     "Filmes de Familia",            .popularFamily),
        (14,    "movie/popular",     "Filmes de Fantasia",           .popularFantasy),
        (36,    "movie/popular",     "Filmes de História",           .popularHistory),
        (27,    "movie/popular",     "Filmes de Terror",             .popularHorror),
        (10402, "movie/popular",     "Filmes Musical",               .popularMusic),
        (9648,  "movie/popular",     "Filmes de Mistério",           .popularRomance),
        (10749, "movie/popular",     "Filmes de Romance",            .popularMystery),
        (878,   "movie/popular",     "Filmes de Ficção Ciêntifica",   .popularScienceFiction),
        (10770, "movie/popular",     "Filmes de TV ",                .popularTVMovie),
        (53,    "movie/popular",     "Filmes de Suspense",           .popularThriller),
        (10752, "movie/popular",     "Filmes de Guerra",              .popularWar),
        (37,    "movie/popular",     "Filmes de Faroeste",           .popularWestern)
    ]
}

//
//  ControllerHome.swift
//  ZPMAPP
//
//  Created by Alan Silva on 18/09/21.
//

import Foundation

class ControllerHome {
    
    typealias LayoutSectionItemsTuple = (generId: Int, pathAPI: String, header: String, enumHome: HomeSection)
    
    let path: [LayoutSectionItemsTuple] = [
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
        (53,    "movie/popular",     "Filmes de Thriller",           .popularThriller),
        (10752, "movie/popular",     "Filmes de Gerra",              .popularWar),
        (37,    "movie/popular",     "Filmes de Faroeste",           .popularWestern)
    ]
    
    let dataNetwork: DataNetwork = DataNetwork()
    var arrayMovies: [DataMovies] = []
    
    func getData(value: HomeSection, completion: @escaping (Bool, Error?) -> Void) {
        let urlPath = path.first { $0.enumHome == value }
        
        dataNetwork.fetchData(urlString: urlPath!.pathAPI, genres: urlPath!.generId) { (data: APIMovieData) in
            self.arrayMovies = data.results
                completion(true, nil)
        }
    }
    
    func getQtd() -> Int {
        return self.arrayMovies.count
    }
    
    func getInfoData(indexPath: IndexPath) -> DataMovies {
        return self.arrayMovies[indexPath.row]
    }
    
    func extracImage(data: String) -> URL? {
        let path = "https://image.tmdb.org/t/p/original/"
        return URL(string: "\(path)\(data)")
    }
    
    func getTitleSection(section: Int) -> String {
        return self.path[section].header
    }
}

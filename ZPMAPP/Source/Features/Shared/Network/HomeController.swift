//
//  HomeController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 14/09/21.
//

import Foundation
import Alamofire

class HomeController {
    
    typealias LayoutSectionItemsTuple = (generId: Int, pathAPI: String, header: String, enumHome: HomeSection)

    let path: [LayoutSectionItemsTuple] = [
        (0,     "trending/all/week", "Os mais assistidos da semana", .topTrending),
        (28,    "movie/popular",     "Filmes de Ação",             .popularAction),
        (12,    "movie/popular",  "Filmes de Aventura",          .popularAdventure),
        (16,    "movie/popular",  "Filmes de Animação",          .popularAnimation),
        (35,    "movie/popular",  "Filmes de Comédia",           .popularComedy),
        (80,    "movie/popular",  "Filmes de Crime",             .popularCrime),
        (99,    "movie/popular",  "Filmes de Documentário",      .popularDocumentary),
        (18,    "movie/popular",  "Filmes de Drama",             .popularDrama),
        (10751, "movie/popular",    "Filmes de Familia",           .popularFamily),
        (14,    "movie/popular",  "Filmes de Fantasia",          .popularFantasy),
        (36,    "movie/popular",  "Filmes de História",          .popularHistory),
        (27,    "movie/popular",  "Filmes de Terror",            .popularHorror),
        (10402, "movie/popular",    "Filmes Musical",              .popularMusic),
        (9648,  "movie/popular",    "Filmes de Mistério",          .popularRomance),
        (10749, "movie/popular",    "Filmes de Romance",           .popularMystery),
        (878,   "movie/popular",   "Filmes de Ficção Ciêntifica",  .popularScienceFiction),
        (10770, "movie/popular",    "Filmes de TV ",               .popularTVMovie),
        (53,    "movie/popular",  "Filmes de Thriller",          .popularThriller),
        (10752, "movie/popular",    "Filmes de Gerra",             .popularWar),
        (37,    "movie/popular",  "Filmes Western",              .popularWestern)
    ]
    
    let link = "https://api.themoviedb.org/3/"
    let priveteKey = "?api_key=94c4c2a4418277655f5960a67c8ffbf6"
    
    var arrayData: [DataMovies] = []
    var filmes: [DataMovies] = []
    
   
    func getTitleSection(section: Int) -> String {
        return self.path[section].header
    }
    
    func getData(filename: HomeSection, completion: @escaping (Bool, Error?) -> Void) {
        guard let caminho = path.first(where: { $3 == filename }) else { return }
        
        let url = ("\(link)\(caminho.pathAPI)\(priveteKey)")
        print ("####LINK:\(caminho.pathAPI) \(url)")
        AF.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let result: APIMovieData = try JSONDecoder().decode(APIMovieData.self, from: data)
                    self.arrayData = result.results
                    self.filterMovies(data: self.arrayData, tipo: caminho)
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
            }
        }
    }
    
    func filterMovies(data: [DataMovies], tipo: LayoutSectionItemsTuple) {
        
        switch tipo.enumHome {
        case .popularAction:
             filmes = data.filter({ return $0.genre_ids.contains(28)})
        case .popularAdventure:
             filmes = data.filter({ return $0.genre_ids.contains(12)})
        case .popularAnimation:
             filmes = data.filter({ return $0.genre_ids.contains(16)})
        case .popularComedy:
             filmes = data.filter({ return $0.genre_ids.contains(35)})
        case .popularCrime:
             filmes = data.filter({ return $0.genre_ids.contains(80)})
        case .popularDocumentary:
             filmes = data.filter({ return $0.genre_ids.contains(99)})
        case .popularDrama:
             filmes = data.filter({ return $0.genre_ids.contains(18)})
        case .popularFamily:
             filmes = data.filter({ return $0.genre_ids.contains(10751)})
        case .popularFantasy:
             filmes = data.filter({ return $0.genre_ids.contains(14)})
        case .popularHistory:
             filmes = data.filter({ return $0.genre_ids.contains(36)})
        case .popularHorror:
             filmes = data.filter({ return $0.genre_ids.contains(27)})
        case .popularMusic:
             filmes = data.filter({ return $0.genre_ids.contains(10402)})
        case .popularMystery:
             filmes = data.filter({ return $0.genre_ids.contains(9648)})
        case .popularRomance:
             filmes = data.filter({ return $0.genre_ids.contains(10749)})
        case .popularScienceFiction:
             filmes = data.filter({ return $0.genre_ids.contains(878)})
        case .popularTVMovie:
             filmes = data.filter({ return $0.genre_ids.contains(10770)})
        case .popularThriller:
             filmes = data.filter({ return $0.genre_ids.contains(53)})
        case .popularWar:
             filmes = data.filter({ return $0.genre_ids.contains(10752)})
        case .popularWestern:
             filmes = data.filter({ return $0.genre_ids.contains(37)})
        default:
            filmes = data
        }
    }
    
    func getQtyData() -> Int {
        return filmes.count
    }
    
    func getInfoData(indexPath: IndexPath) -> DataMovies {
        print("##INFO:\(indexPath.row) - \(filmes[indexPath.row].name) \(filmes[indexPath.row].genre_ids)")
        return filmes[indexPath.row]
    }
    
    func extracImage(data: String) -> URL? {
        let path = "https://image.tmdb.org/t/p/w500/"
        return URL(string: "\(path)\(data)")
    }
}



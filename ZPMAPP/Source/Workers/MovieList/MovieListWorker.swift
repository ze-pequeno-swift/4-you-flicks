//
//  MovieListWorker.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

typealias MovieListResult = (Result<MovieListResponse, MovieError>) -> Void

protocol MovieWorkerProtocol {

    func fetchDailyTrendings(completion: @escaping MovieListResult)
    
    func fecthMovieWithGenre(section: Section, type: Type, idGenre: Int,
                             completion: @escaping MovieListResult)
}

class MovieListWorker: MovieWorkerProtocol {
    
    func fetchDailyTrendings(completion: @escaping MovieListResult) {
        let url = MovieAPI.buildDailyTrendings()
        
        NetworkManager.request(url: url) { result in
            completion(result)
        }
    }
    
    func fecthMovieWithGenre(section: Section, type: Type, idGenre: Int, completion: @escaping MovieListResult) {
        let url = MovieAPI.buildWithGenre(section: section, type: type, idGenre: idGenre)
        
        NetworkManager.request(url: url) { result in
            completion(result)
        }
    }
}

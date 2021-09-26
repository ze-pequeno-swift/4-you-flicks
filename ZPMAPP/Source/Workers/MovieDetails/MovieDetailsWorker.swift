//
//  MovieDetailsWorker.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

typealias MovieDetailsResult = (Result<MovieDetailsResponse?, MovieError>) -> Void

protocol MovieDetailsWorkerProtocol {
    
    func fetchMovieDetails(of movieID: Int,
                           completion: @escaping MovieDetailsResult)
}

class MovieDetailsWorker: MovieDetailsWorkerProtocol {
    
    func fetchMovieDetails(of movieID: Int, completion: @escaping MovieDetailsResult) {
        let url = MovieAPI.buildDetails(type: .movie, detailsOf: movieID)
        
        NetworkManager.request(url: url) { result in
            completion(result)
        }
    }
}

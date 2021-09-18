//
//  Network.swift
//  ZPMAPP
//
//  Created by Alan Silva on 18/09/21.
//

import Foundation
import Alamofire

class DataNetwork {
    
    private let link = "https://api.themoviedb.org/3/"
    private let priveteKey = "?api_key=94c4c2a4418277655f5960a67c8ffbf6"


    //https://api.themoviedb.org/3/movie/popular?api_key=4a2227bffae9ea53eebcaa7d05098303&language=pt-BR&page=1&with_genres=18&watch_region=BR
    
    func fetchData<T: Decodable>(urlString: String, genres: Int, completion: @escaping (T) -> Void) {
        var url: String = " "
        if genres == 0 {
            url = ("\(link)\(urlString)\(priveteKey)")
        } else {
            url = ("\(link)\(urlString)\(priveteKey)\("&with_genres=")\(genres)")
        }
        print("MINHA_URL: \(url)")
        AF.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result)
                } catch let apiError {
                    print("Erro to get API: ", apiError)
                }
            }
        }
    }

//    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T) -> Void) {
//        let url = ("\(link)\(urlString)\(priveteKey)")
//        print("MINHA_URL: \(url)")
//        AF.request(url).responseJSON { response in
//            if let data = response.data {
//                do {
//                    let result = try JSONDecoder().decode(T.self, from: data)
//                    completion(result)
//                } catch let apiError {
//                    print("Erro to get API: ", apiError)
//                }
//            }
//        }
//    }
}

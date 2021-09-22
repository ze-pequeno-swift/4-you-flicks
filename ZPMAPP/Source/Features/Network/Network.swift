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
    private var url: String = ""

    func fetchData<T: Decodable>(urlString: String, genres: Int, completion: @escaping (T) -> Void) {
        if genres == 0 {
            url = ("\(link)\(urlString)\(priveteKey)")
            print("MINHA_URL:\(url)")
        } else {
            url = ("\(link)\(urlString)\(priveteKey)\("&with_genres=")\(genres)")
        }
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
}

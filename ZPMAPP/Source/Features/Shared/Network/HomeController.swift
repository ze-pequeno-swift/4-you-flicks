//
//  HomeController.swift
//  ZPMAPP
//
//  Created by Alan Silva on 14/09/21.
//

import Foundation
import Alamofire

class HomeController {
    let link = "https://api.themoviedb.org/3/"
    let priveteKey = "?api_key=94c4c2a4418277655f5960a67c8ffbf6"
    
    var arrayData: [DataMovies] = []
   
    func getData(filename: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = ("\(link)\(filename)\(priveteKey)")
    
        AF.request(url).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let result: APIMovieData = try JSONDecoder().decode(APIMovieData.self, from: data)
                    self.arrayData = result.results
                    completion(true, nil)
                } catch {
                    print("###########\(error)")
                    completion(false, error)
                }
            }
        }
    }
    
    func getQtyData() -> Int {
        return arrayData.count
    }
    func getInfoData(indexPath: IndexPath) -> DataMovies {
        return arrayData[indexPath.row]
    }
    
    func extracImage(data: String) -> URL? {
        let path = "https://image.tmdb.org/t/p/w500/"
        
        return URL(string: "\(path)\(data)")
    }
}

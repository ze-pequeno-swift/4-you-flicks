//
//  MovieListResponse.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct MovieListResponse: Decodable {
    
    let results: [Movie]
}

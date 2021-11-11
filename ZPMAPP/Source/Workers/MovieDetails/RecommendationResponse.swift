//
//  RecommendationResponse.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct RecommendationResponse: Decodable {
    
    let page: Int
    
    let results: [Movie]
}

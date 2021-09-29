//
//  MovieDetailsResponse.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct MovieDetailsResponse: Decodable {
    
    let runtime: Int
    
    let genres: [Genre]
    
    let credits: Credits

    let recommendations: RecommendationResponse
    
//    let watchProviders: WatchProvidersResponse
}

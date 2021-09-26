//
//  Details.swift
//  ZPMAPP
//
//  Created by Hellen on 25/09/21.
//

import Foundation

struct Details {
    
    var genres: String = ""
    
    var duration: String = ""
    
    var cast: [Cast] = []
    
    var recommendations: [Movie] = []
    
    init() { }

    init(_ response: MovieDetailsResponse) {
        self.duration = response.runtime.durationFormat ?? ""
        
        self.cast = Array(response
            .credits.cast)
        
        self.genres = response.genres
            .prefix(2)
            .map({ $0.name })
            .joined(separator: ", ")
        
        self.recommendations = response.recommendations.results
    }
}

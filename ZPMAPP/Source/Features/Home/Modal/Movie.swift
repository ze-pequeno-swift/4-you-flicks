//
//  Movie.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct Movie: Decodable {

    let id: Int

    let title: String

    let overview: String
    
    let releaseDate: String
    
    var voteAverage: Double
    
    let posterPath: String?
    
    let backdropPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

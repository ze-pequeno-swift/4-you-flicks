//
//  Movie.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import Foundation

struct Movie: Codable {
    let movies: [MovieList]
}

struct MovieList: Codable {
    let title: String
    let image: String
    let length: String
    let genre: String
    let name: String
}

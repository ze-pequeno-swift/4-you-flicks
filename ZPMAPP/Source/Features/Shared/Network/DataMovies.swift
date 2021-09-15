//
//  DataMovies.swift
//  ZPMAPP
//
//  Created by Alan Silva on 14/09/21.
//

import Foundation

struct AIPResult: Codable {
    let results: [dataMovies]
}
struct dataMovies: Codable {
    let id: Int
}

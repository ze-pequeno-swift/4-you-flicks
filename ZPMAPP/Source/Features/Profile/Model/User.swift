//
//  User.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

struct User: Decodable {
    let id, name, email, password: String
    let username, avatar: String?
    let movies: [Movie]?
    let friends: [Friend]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case movies = "movies"
        case friends = "friends"
        case password = "password"
        case username = "username"
        case avatar = "avatar"
    }
}

//
//  Friend.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

// MARK: - Friend
struct Friend: Codable {
    let followers, followings: [String]
}

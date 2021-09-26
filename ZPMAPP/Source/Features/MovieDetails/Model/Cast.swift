//
//  Cast.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct Cast: Decodable {

    let name: String
    
    let character: String
    
    let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case character = "character"
        case profilePath = "profile_path"
    }
}

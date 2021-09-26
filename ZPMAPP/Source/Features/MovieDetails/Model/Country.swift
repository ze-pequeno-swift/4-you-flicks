//
//  Country.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct Country: Decodable {
    
    let brasil: [Brasil]
    
    private enum CodingKeys: String, CodingKey {
        case brasil = "BR"
    }
}

struct Brasil: Decodable {
    
    let flatrate: [Flatrate]
}

struct Flatrate: Decodable {
    
    let providerId: Int
    let providerName: String
    let logoPath: String
    
    private enum CodingKeys: String, CodingKey {
        case providerId = "provider_id"
        case providerName = "rovider_name"
        case logoPath = "logo_path"
    }
}

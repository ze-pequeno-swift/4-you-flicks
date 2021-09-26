//
//  MovieAPI.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

struct MovieAPI {
    
    // MARK: - Definitions
    
    enum ImageSize: String {
        case original
        case w780
        case w500
        case w300
        case w200
    }
    
    // MARK: - Internal Properties
    
    static let key: String = "4a2227bffae9ea53eebcaa7d05098303"
    static let version: Int = 3
    static let baseURL: String = "https://api.themoviedb.org/\(MovieAPI.version)"
    static let imageURL: String = "https://image.tmdb.org/t/p"
    
    static var language: String {
        return Locale.current.collatorIdentifier ?? "pt"
    }
    
    static func build(image: String, size: ImageSize) -> String {
        return "\(MovieAPI.imageURL)/\(size.rawValue)/\(image)"
    }
    
    static func buildPopular(section: Section, type: Type, page: Int) -> String {
        return "\(MovieAPI.baseURL)/\(type.rawValue)/\(section.rawValue)"
            + "?api_key=\(MovieAPI.key)&language=\(language)&page=\(page)"
    }
    
    static func buildDailyTrendings() -> String {
        return "\(MovieAPI.baseURL)/trending/movie/week"
            + "?api_key=\(MovieAPI.key)&language=\(language)"
            + "&watch_region=BR"
    }

    static func buildWithGenre(section: Section, type: Type, idGenre: Int) -> String {
        return "\(MovieAPI.baseURL)/\(type.rawValue)/\(section.rawValue)"
            + "?api_key=\(MovieAPI.key)&language=\(language)"
            + "&with_genres=\(idGenre)&watch_region=BR"
    }
    
    static func buildDetails(type: Type, detailsOf id: Int) -> String {
        return "\(MovieAPI.baseURL)/\(type.rawValue)/\(id)?api_key=\(MovieAPI.key)"
            + "&language=\(language)&append_to_response=videos,credits,recommendations"
    }
}

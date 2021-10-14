//
//  Movie.swift
//  ZPMAPP
//
//  Created by Hellen on 24/09/21.
//

import Foundation

// MARK: - Movie

struct Movie: Codable {

    let id: Int

    let title: String

    let overview: String
    
    let releaseDate: String
    
    let voteAverage: Double
    
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

// MARK: Movie convenience initializers and mutators

extension Movie {

    init(data: Data) throws {
        self = try JSONService.getJSONDecoder().decode(Movie.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func dictionary() throws -> [String: Any] {
        let data = try self.jsonData()
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
          throw NSError()
        }
        
        return dictionary
    }

    func jsonData() throws -> Data {
        return try JSONService.getJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

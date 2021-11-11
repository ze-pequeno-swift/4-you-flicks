//
//  MyMovie.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 11/10/21.
//

import Foundation

// MARK: - MyMovies

struct MyMovie: Codable {
    var movie: Movie?
    var tag: String
    var id: String
}

// MARK: MyMovies convenience initializers and mutators

extension MyMovie {
    init(data: Data) throws {
        self = try JSONService.getJSONDecoder().decode(MyMovie.self, from: data)
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

    func with(
        movie: Movie? = nil,
        tag: String? = nil,
        id: String? = nil
    ) -> MyMovie {
        return MyMovie(
            movie: movie ?? self.movie,
            tag: tag ?? self.tag,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try JSONService.getJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

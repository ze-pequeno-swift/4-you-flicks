//
//  User.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import Foundation

// MARK: - Customer

struct Customer: Codable {
    var email: String
    var name, username, avatar: String?
    var myMovies: [MyMovie]?
    var friends: [Friend]?
}

// MARK: Customer convenience initializers and mutators

extension Customer {
    init(data: Data) throws {
        self = try JSONService.getJSONDecoder().decode(Customer.self, from: data)
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
    
    func getCurrentCustomer() -> Customer {
        return self
    }
}

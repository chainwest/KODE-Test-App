//
//  Response.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct Recipe {
    var name: String
    var images: [String]
    var lastUpdated: Int
    var instructions: String
    var description: String?
    var difficulty: Int
}

extension Recipe: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case images
        case lastUpdated
        case instructions
        case description
        case difficulty
    }

    init(from: Decoder) throws {
        let values = try from.container(keyedBy: CodingKeys.self)
        let descriptionString = try? values.decode(String.self, forKey: .description)
        self.name = try values.decode(String.self, forKey: .name)
        self.images = try values.decode([String].self, forKey: .images)
        self.lastUpdated = try values.decode(Int.self, forKey: .lastUpdated)
        self.instructions = try values.decode(String.self, forKey: .instructions)
        self.difficulty = try values.decode(Int.self, forKey: .difficulty)
        
        if descriptionString == nil || descriptionString == "" {
            self.description = "Wow, there is no description!"
        } else {
            self.description = descriptionString
        }
    }
}

struct Response: Decodable {
    var recipes: [Recipe]?
}

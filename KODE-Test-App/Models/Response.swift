//
//  Response.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct Recipe: Decodable {
    var name: String
    var images: [String]
    var instructions: String
    var description: String?
    var difficulty: Int
}

struct Response: Decodable {
    var recipes: [Recipe]?
}

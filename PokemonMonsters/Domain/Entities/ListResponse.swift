//
//  ListResponse.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

struct ListResponse: Codable, Equatable {
    let count: Int
    let results: [Pokemon]
    let next: String
    let previous: String?
}

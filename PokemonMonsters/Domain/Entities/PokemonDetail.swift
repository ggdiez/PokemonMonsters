//
//  PokemonDetail.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

struct PokemonDetail: Codable, Equatable {
    let id: Int
    let name: String
    let sprites: Sprites
}

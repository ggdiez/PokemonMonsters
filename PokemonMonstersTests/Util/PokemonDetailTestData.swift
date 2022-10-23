//
//  PokemonDetailTestData.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
@testable import PokemonMonsters

enum PokemonDetailTestDataMain {
    static let id = 1
    static let name = "pokemon 1"
    static let sprites: Sprites = Sprites.main()
}

enum PokemonDetailTestDataAlt {
    static let id = 2
    static let name = "pokemon 2"
    static let sprites: Sprites = Sprites.alt()
}

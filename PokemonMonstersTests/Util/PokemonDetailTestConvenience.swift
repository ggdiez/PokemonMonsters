//
//  PokemonDetailTestConvenience.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//


import Foundation
@testable import PokemonMonsters

extension PokemonDetail {
    static func main() -> PokemonDetail {
        PokemonDetail(id: PokemonDetailTestDataMain.id, name: PokemonDetailTestDataMain.name, sprites: PokemonDetailTestDataMain.sprites)
    }

    static func alt() -> PokemonDetail {
        PokemonDetail(id: PokemonDetailTestDataAlt.id, name: PokemonDetailTestDataAlt.name, sprites: PokemonDetailTestDataAlt.sprites)
    }
}

//
//  PokemonTestConvenience.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
@testable import PokemonMonsters

extension Pokemon {
    static func main() -> Pokemon {
        Pokemon(name: PokemonTestDataMain.name, url: PokemonTestDataMain.url)
    }

    static func alt() -> Pokemon {
        Pokemon(name: PokemonTestDataAlt.name, url: PokemonTestDataAlt.url)
    }
}

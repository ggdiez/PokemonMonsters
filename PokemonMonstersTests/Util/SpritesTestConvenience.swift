//
//  SpritesTestConvenience.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
@testable import PokemonMonsters

extension Sprites {
    static func main() -> Sprites {
        Sprites(frontDefault: SpritesTestDataMain.frontDefault)
    }

    static func alt() -> Sprites {
        Sprites(frontDefault: SpritesTestDataAlt.frontDefault)
    }
}

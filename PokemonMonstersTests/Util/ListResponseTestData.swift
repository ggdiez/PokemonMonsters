//
//  ListResponseTestData.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
@testable import PokemonMonsters

enum ListResponseTestDataMain {
    static let count = 2
    static let results = [Pokemon.main(), Pokemon.alt()]
    static let next = "next url 1"
    static let previous = "previous url 1"
}

enum ListResponseTestDataAlt {
    static let count = 2
    static let results = [Pokemon.alt(), Pokemon.main()]
    static let next = "next url 2"
    static let previous = "previous url 2"
}

//
//  PokemonDetailItemViewModel.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

struct PokemonDetailItemViewModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageURLPath: String
}

extension PokemonDetailItemViewModel {
    init(pokemon: PokemonDetail) {
        id = pokemon.id
        name = pokemon.name
        imageURLPath = pokemon.sprites.frontDefault
    }
}

//
//  PokemonItemViewModel.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

struct PokemonItemViewModel: Identifiable, Equatable {
    var id = UUID()
    let name: String
    let url: String
}

extension PokemonItemViewModel {
    init(pokemon: Pokemon) {
        name = pokemon.name
        url = pokemon.url
    }
}

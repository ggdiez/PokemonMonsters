//
//  PokemonCryConnector.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
import SwiftUI

protocol PokemonCryViewConnector {}

final class PokemonCryConnector: PokemonCryViewConnector {
    func assembleModule (pokemon: PokemonItemViewModel) -> some View {
        let pokemonAPIClient = PokemonAPIClient()
        let pokemonRepository = PokemonRepository(apiClient: pokemonAPIClient)
        let pokemonUseCaseFactory = PokemonUseCaseFactory(gateway: pokemonRepository)
        let viewModel = PokemonCryViewModel(pokemon: pokemon, pokemonUseCaseFactory: pokemonUseCaseFactory)
        return AnyView(PokemonCryView(viewModel: viewModel, connector: self))
    }
}

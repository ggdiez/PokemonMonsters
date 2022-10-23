//
//  PokemonRowConnector.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import SwiftUI

protocol PokemonRowViewConnector {}

final class PokemonRowConnector: PokemonRowViewConnector {
    func assembleModule (pokemon: PokemonItemViewModel) -> some View {
        let pokemonAPIClient = PokemonAPIClient()
        let pokemonRepository = PokemonRepository(apiClient: pokemonAPIClient)
        let pokemonUseCaseFactory = PokemonUseCaseFactory(gateway: pokemonRepository)
        let viewModel = PokemonRowViewModel(pokemon: pokemon, pokemonUseCaseFactory: pokemonUseCaseFactory)
        return AnyView(PokemonRowView(viewModel: viewModel, connector: self))
    }
}

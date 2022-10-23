//
//  HomeConnector.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import SwiftUI

protocol HomeViewConnectorProtocol {
    func navigate(to destination: HomeNavigationDestination?) -> AnyView
}

extension HomeViewConnectorProtocol {
    func navigate(to destination: HomeNavigationDestination?) -> AnyView {
        AnyView(EmptyView())
    }
}

final class HomeConnector: HomeViewConnectorProtocol {
    func assembleModule () -> some View {
        let pokemonListAPIClient = PokemonListAPIClient()

        guard let initialURL = URL(string: API.urlPath) else {
            return AnyView(EmptyView())
        }

        let pokemonListRepository = PokemonListRepository(initialURL: initialURL, apiClient: pokemonListAPIClient)
        let pokemonListUseCaseFactory = PokemonListUseCaseFactory(gateway: pokemonListRepository)
        let viewModel = HomeViewModel(pokemonListUseCaseFactory: pokemonListUseCaseFactory)
        return AnyView(HomeView(viewModel: viewModel, connector: self))
    }

    func navigate(to destination: HomeNavigationDestination?) -> AnyView {
        if let destination = destination {
            switch destination {
            case .toPokemonDetail(let pokemon):
                return AnyView(PokemonCryConnector().assembleModule(pokemon: pokemon))
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}

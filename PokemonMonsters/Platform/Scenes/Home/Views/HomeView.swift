//
//  HomeView.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import SwiftUI

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    private let connector: HomeViewConnectorProtocol
    private let spacing = 10.0
    private let viewTitle = "Pokemons"
    @State private var searchText = ""

    // MARK: - Initializer
    init(viewModel: ViewModel, connector: HomeViewConnectorProtocol) {
        self.viewModel = viewModel
        self.connector = connector
    }

    // MARK: - View
    var body: some View {
        NavigationView {
            List(searchResults) { pokemon in
                PokemonRowConnector().assembleModule(pokemon: pokemon)
                    .onAppear {
                        viewModel.loadMoreContentIfNeeded(currentItem: pokemon)
                    }
                    .onTapGesture {
                        viewModel.navigateTo(destination: .toPokemonDetail(pokemon: pokemon))
                    }
                    .sheet(isPresented: $viewModel.navigate, onDismiss: {}, content: {
                        connector.navigate(to: viewModel.navigationDestination)
                    })
            }
            .searchable(text: $searchText)
            .navigationTitle(viewTitle)
        }
    }

    var searchResults: [PokemonItemViewModel] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

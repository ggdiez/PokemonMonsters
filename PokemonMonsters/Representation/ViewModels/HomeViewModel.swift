//
//  HomeViewModel.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

enum HomeNavigationDestination: Equatable {
    case toPokemonDetail(pokemon: PokemonItemViewModel)
}

protocol HomeViewModelProtocol: HomeViewModelOutput, HomeViewModelInput {}

protocol HomeViewModelOutput: ObservableObject {
    var navigationDestination: HomeNavigationDestination? { get set }
    var navigate: Bool { get set }
    var pokemonList: [PokemonItemViewModel] { get set }
    func navigateTo(destination: HomeNavigationDestination)
    func getPokemonList()
    func loadMoreContentIfNeeded(currentItem item: PokemonItemViewModel?)
}

protocol HomeViewModelInput: ObservableObject {}

final class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Properties
    @Published var navigationDestination: HomeNavigationDestination?
    @Published var navigate: Bool = false

    private let pokemonListUseCaseFactory: PokemonListUseCaseFactory
    private var pokemonListUseCase: UseCase?
    @Published var pokemonList: [PokemonItemViewModel] = []
    private let positionsToLoadMore = 5

    // MARK: Init
    init(pokemonListUseCaseFactory: PokemonListUseCaseFactory) {
        self.pokemonListUseCaseFactory = pokemonListUseCaseFactory
        self.getPokemonList()
    }

    // MARK: Output functions

    @objc func getPokemonList() {
        executeGetPokemonListUseCase()
    }

    func loadMoreContentIfNeeded(currentItem item: PokemonItemViewModel?) {
        guard let item = item else {
            executeGetPokemonListUseCase()
          return
        }

        let thresholdIndex = pokemonList.index(pokemonList.endIndex, offsetBy: -positionsToLoadMore)
        if pokemonList.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            executeGetPokemonListUseCase()
        }
      }

    func navigateTo(destination: HomeNavigationDestination) {
        self.navigationDestination = destination
        self.navigate = true
    }

    // MARK: Private functions

    private func executeGetPokemonListUseCase () {
        pokemonListUseCase = pokemonListUseCaseFactory.getPokemons(handler: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let pokemons):
                let newPokemons = pokemons.map { PokemonItemViewModel(pokemon: $0) }
                self.pokemonList.append(contentsOf: newPokemons)
            case .failure(let error):
                Log.error("Error getting pokemons from viewModel: \(error)")
            }
            self.pokemonListUseCase = nil
        })
        pokemonListUseCase?.execute()
    }
}

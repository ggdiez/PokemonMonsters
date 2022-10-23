//
//  PokemonRowViewModel.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

protocol PokemonRowViewModelProtocol: PokemonRowViewModelOutput, PokemonRowViewModelInput {}

protocol PokemonRowViewModelOutput: ObservableObject {
    var pokemonItemDetail: PokemonDetailItemViewModel { get set }
    func getPokemonDetail()
    func getPokemonName() -> String
}

protocol PokemonRowViewModelInput: ObservableObject {}

final class PokemonRowViewModel: PokemonRowViewModelProtocol {

    // MARK: - Properties
    private let pokemonUseCaseFactory: PokemonUseCaseFactory
    private let pokemon: PokemonItemViewModel
    private var pokemonUseCase: UseCase?
    @Published var pokemonItemDetail: PokemonDetailItemViewModel

    // MARK: Init
    init(pokemon: PokemonItemViewModel, pokemonUseCaseFactory: PokemonUseCaseFactory) {
        self.pokemon = pokemon
        self.pokemonUseCaseFactory = pokemonUseCaseFactory
        self.pokemonItemDetail = PokemonDetailItemViewModel(id: 1, name: "loading...", imageURLPath: "")
        self.getPokemonDetail()
    }

    // MARK: Output functions

    @objc func getPokemonDetail() {
        executeGetPokemonDetailUseCase()
    }

    func getPokemonName() -> String {
        return pokemon.name
    }

    // MARK: Private functions

    private func executeGetPokemonDetailUseCase () {

        if let url = URL(string: pokemon.url) {
            pokemonUseCase = pokemonUseCaseFactory.getPokemonDetail(url: url,handler: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let pokemonDetail):
                    self.pokemonItemDetail = PokemonDetailItemViewModel(pokemon: pokemonDetail)
                case .failure(let error):
                    Log.error("Error getting pokemon from viewModel: \(error)")
                }
                self.pokemonUseCase = nil
            })
            pokemonUseCase?.execute()
        }
    }
}


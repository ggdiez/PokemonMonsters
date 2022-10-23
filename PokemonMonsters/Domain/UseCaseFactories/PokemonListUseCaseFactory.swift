//
//  PokemonListUseCaseFactory.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

class PokemonListUseCaseFactory {
    // MARK: - Properties
    let gateway: PokemonListGateway

    // MARK: - Init
    init (gateway: PokemonListGateway) {
        self.gateway = gateway
    }

    // MARK: - Factory methods
    func getPokemons(handler: @escaping Handler<[Pokemon]>) -> UseCase {
        PokemonListUseCase(entityGateway: gateway, handler: handler)
    }
}

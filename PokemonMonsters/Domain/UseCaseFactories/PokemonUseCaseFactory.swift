//
//  PokemonUseCaseFactory.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

class PokemonUseCaseFactory {
    // MARK: - Properties
    let gateway: PokemonGateway

    // MARK: - Init
    init (gateway: PokemonGateway) {
        self.gateway = gateway
    }

    // MARK: - Factory methods
    func getPokemonDetail(url: URL, handler: @escaping Handler<PokemonDetail>) -> UseCase {
        PokemonDetailUseCase(entityGateway: gateway, url: url, handler: handler)
    }
}

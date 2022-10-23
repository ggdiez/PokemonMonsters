//
//  PokemonListUseCase.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

final class PokemonListUseCase {
    // MARK: - Properties
    private let entityGateway: PokemonListGateway
    private let handler: Handler<[Pokemon]>
    private var cancellable: AnyCancellable?

    // MARK: - Init
    init(entityGateway: PokemonListGateway, handler: @escaping Handler<[Pokemon]>) {
        self.entityGateway = entityGateway
        self.handler = handler
    }
}

extension PokemonListUseCase: UseCase {
    // MARK: - Method
    func execute() {
        cancellable = entityGateway.getPokemons()
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?.handler(.failure(.unaccessible))
                }
            }, receiveValue: { [weak self] pokemons in
                self?.handler(.success(pokemons))
            })
    }
}

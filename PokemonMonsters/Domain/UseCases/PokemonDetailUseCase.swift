//
//  PokemonDetailUseCase.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

final class PokemonDetailUseCase {
    // MARK: - Properties
    private let entityGateway: PokemonGateway
    private let handler: Handler<PokemonDetail>
    private let url: URL
    private var cancellable: AnyCancellable?

    // MARK: - Init
    init(entityGateway: PokemonGateway, url: URL, handler: @escaping Handler<PokemonDetail>) {
        self.entityGateway = entityGateway
        self.url = url
        self.handler = handler
    }
}

extension PokemonDetailUseCase: UseCase {
    // MARK: - Method
    func execute() {
        cancellable = entityGateway.getPokemonDetail(url: url)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?.handler(.failure(.unaccessible))
                }
            }, receiveValue: { [weak self] pokemon in
                self?.handler(.success(pokemon))
            })
    }
}

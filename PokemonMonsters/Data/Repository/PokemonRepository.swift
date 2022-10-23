//
//  PokemonRepository.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

final class PokemonRepository: PokemonGateway {
    private let apiClient: PokemonAPIClientProtocol
    private var cancellable: AnyCancellable?

    // MARK: - Init
    init(apiClient: PokemonAPIClientProtocol) {
        self.apiClient = apiClient
    }
}

extension PokemonRepository {

    // MARK: - Pokemons methods
    func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError> {
        Future<PokemonDetail, PokemonGatewayError> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.unaccessible))
            }

            self.cancellable = self.apiClient.getPokemonDetail(url: url)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        if error == .unaccessible {
                            return promise(.failure(.unaccessible))
                        } else {
                            return promise(.failure(error))
                        }
                    }
                }, receiveValue: { pokemon in
                    return promise(.success(pokemon))
                })
        }.eraseToAnyPublisher()
    }
}

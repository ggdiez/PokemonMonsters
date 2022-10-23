//
//  PokemonAPIClient.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

protocol PokemonAPIClientProtocol {
    func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError>
}

final class PokemonAPIClient: PokemonAPIClientProtocol {
    // MARK: - Properties
    private var cancellable: AnyCancellable?

    // MARK: - Init
    init() {}

    // MARK: - Methods
    func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError> {
        Future<PokemonDetail, PokemonGatewayError> { [weak self] promise in
            self?.cancellable = Network().call(url: url)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        return promise(.failure(.unaccessible))
                    }
                }, receiveValue: { data in
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let pokemon: PokemonDetail = try decoder.decode(PokemonDetail.self, from: data)
                        return promise(.success(pokemon))
                    } catch {
                        Log.error("error decoding collection: \(error)")
                        return promise(.failure(.errorDecoding))
                    }
                })
        }.eraseToAnyPublisher()
    }
}

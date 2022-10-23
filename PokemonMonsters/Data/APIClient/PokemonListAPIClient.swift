//
//  PokemonListAPIClient.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

protocol PokemonListAPIClientProtocol {
    func getPokemonList(url: URL) -> AnyPublisher<ListResponse, PokemonListGatewayError>
}

final class PokemonListAPIClient: PokemonListAPIClientProtocol {

    // MARK: - Properties
    private var cancellable: AnyCancellable?

    // MARK: - Init
    init() {}

    // MARK: - Methods
    func getPokemonList(url: URL) -> AnyPublisher<ListResponse, PokemonListGatewayError> {
        Future<ListResponse, PokemonListGatewayError> { [weak self] promise in
            self?.cancellable = Network().call(url: url)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        return promise(.failure(.unaccessible))
                    }
                }, receiveValue: { data in
                    do {
                        let decoder = JSONDecoder()
                        let collection: ListResponse = try decoder.decode(ListResponse.self, from: data)
                        return promise(.success(collection))
                    } catch {
                        Log.error("error decoding collection: \(error)")
                        return promise(.failure(.errorDecoding))
                    }
                })

        }.eraseToAnyPublisher()
    }
}


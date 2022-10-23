//
//  PokemonListRepository.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

final class PokemonListRepository: PokemonListGateway {
    private let apiClient: PokemonListAPIClientProtocol
    private let initialURL: URL
    private var cancellable: AnyCancellable?
    private var listResponse: ListResponse?
    private var list: [Pokemon] = []


    // MARK: - Init
    init(initialURL: URL, apiClient: PokemonListAPIClientProtocol) {
        self.initialURL = initialURL
        self.apiClient = apiClient
    }
}

extension PokemonListRepository {

    // MARK: - Pokemons methods
    func getPokemons() -> AnyPublisher<[Pokemon], PokemonListGatewayError> {

        Future<[Pokemon], PokemonListGatewayError> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.unaccessible))
            }

            var nextUrl = self.initialURL

            if let listResponse = self.listResponse {
                guard let nextURL = URL(string: listResponse.next) else {
                    return
                }

                nextUrl = nextURL
            }

            self.cancellable = self.apiClient.getPokemonList(url: nextUrl)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        if error == .unaccessible {
                            return promise(.failure(.unaccessible))
                        } else {
                            return promise(.failure(error))
                        }
                    }
                }, receiveValue: { listResponse in
                    self.listResponse = listResponse
                    self.list.append(contentsOf: listResponse.results)
                    print("List Response count: \(self.list.count)")
                    return promise(.success(listResponse.results))
                })
        }.eraseToAnyPublisher()
    }
}

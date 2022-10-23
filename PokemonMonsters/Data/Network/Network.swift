//
//  Network.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

class Network {

    func call(url: URL) -> AnyPublisher<Data, Error> {
        do {
            return URLSession.shared.dataTaskPublisher(for: url)
                .map {
                    Log.networkResponse(response: $0.response as? HTTPURLResponse, data: $0.data)
                    return $0.data
                }
                .mapError { (error: URLError) -> Error in
                    Log.networkError("Error found: \(error)")
                    return error
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()

        } catch let error {
            return Fail<Data, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

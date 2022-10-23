//
//  PokemonGateway.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

enum PokemonGatewayError: Error {
    case unaccessible
    case errorDecoding
}

protocol PokemonGateway {
    func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError>
}

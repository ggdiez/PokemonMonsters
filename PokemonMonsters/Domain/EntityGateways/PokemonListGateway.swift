//
//  PokemonListGateway.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation
import Combine

enum PokemonListGatewayError: Error {
    case unaccessible
    case errorDecoding
}

protocol PokemonListGateway {
    func getPokemons() -> AnyPublisher<[Pokemon], PokemonListGatewayError>
}

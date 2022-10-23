//
//  EntityGatewayTestDummy.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
import Combine
@testable import PokemonMonsters

class PokemonListGatewayTestDummy: PokemonListGateway {
    func getPokemons() -> AnyPublisher<[Pokemon], PokemonListGatewayError> {
        Empty().setFailureType(to: PokemonListGatewayError.self).eraseToAnyPublisher()
    }


}

class PokemonGatewayTestDummy: PokemonGateway {
    func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError> {
        Empty().setFailureType(to: PokemonGatewayError.self).eraseToAnyPublisher()
    }
}


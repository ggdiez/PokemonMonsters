//
//  Handler.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

enum DomainError: Error, Equatable {
    case persistence
    case unaccessible
    case messageError(String)
    case userDefaultsError
    case errorCall
    case accessDenied(String)
    case badURL
    case nothingToRecover
}

typealias Handler<T> = (Result<T, DomainError>) -> Void

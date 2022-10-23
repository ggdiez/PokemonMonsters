//
//  ListResponseTestConvenience.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
@testable import PokemonMonsters

extension ListResponse {
    static func main() -> ListResponse {
        ListResponse(count: ListResponseTestDataMain.count, results: ListResponseTestDataMain.results, next: ListResponseTestDataMain.next, previous: ListResponseTestDataMain.previous)
    }

    static func alt() -> ListResponse {
        ListResponse(count: ListResponseTestDataAlt.count, results: ListResponseTestDataAlt.results, next: ListResponseTestDataAlt.next, previous: ListResponseTestDataAlt.previous)
    }
}

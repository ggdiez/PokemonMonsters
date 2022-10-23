//
//  PokemonDetailTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
@testable import PokemonMonsters

class PokemonDetailTest: XCTestCase {
    var sut: PokemonDetail!
    override func setUpWithError() throws {
        sut = PokemonDetail.main()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testMainParamsAreTheExpected() {
        XCTAssertEqual(PokemonDetailTestDataMain.name, sut.name)
        XCTAssertEqual(PokemonDetailTestDataMain.id, sut.id)
        XCTAssertEqual(PokemonDetailTestDataMain.sprites, sut.sprites)
    }

    func testAltValuesIsAltValues() {
        sut = PokemonDetail.alt()
        XCTAssertEqual(PokemonDetailTestDataAlt.name, sut.name)
        XCTAssertEqual(PokemonDetailTestDataAlt.id, sut.id)
        XCTAssertEqual(PokemonDetailTestDataAlt.sprites, sut.sprites)
    }
}


//
//  PokemonTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
@testable import PokemonMonsters

class PokemonTest: XCTestCase {
    var sut: Pokemon!
    override func setUpWithError() throws {
        sut = Pokemon.main()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testMainParamsAreTheExpected() {
        XCTAssertEqual(PokemonTestDataMain.name, sut.name)
        XCTAssertEqual(PokemonTestDataMain.url, sut.url)
    }
    func testAltValuesIsAltValues() {
        sut = Pokemon.alt()
        XCTAssertEqual(PokemonTestDataAlt.name, sut.name)
        XCTAssertEqual(PokemonTestDataAlt.url, sut.url)
    }
}

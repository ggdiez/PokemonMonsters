//
//  SpritesTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
@testable import PokemonMonsters

class SpritesTest: XCTestCase {
    var sut: Sprites!
    override func setUpWithError() throws {
        sut = Sprites.main()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testMainParamsAreTheExpected() {
        XCTAssertEqual(SpritesTestDataMain.frontDefault, sut.frontDefault)
    }
    func testAltValuesIsAltValues() {
        sut = Sprites.alt()
        XCTAssertEqual(SpritesTestDataAlt.frontDefault, sut.frontDefault)
    }
}


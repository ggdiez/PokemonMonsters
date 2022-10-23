//
//  ListResponseTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
@testable import PokemonMonsters

class ListReponseTest: XCTestCase {
    var sut: ListResponse!
    override func setUpWithError() throws {
        sut = ListResponse.main()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testMainParamsAreTheExpected() {
        XCTAssertEqual(ListResponseTestDataMain.count, sut.count)
        XCTAssertEqual(ListResponseTestDataMain.results, sut.results)
        XCTAssertEqual(ListResponseTestDataMain.previous, sut.previous)
        XCTAssertEqual(ListResponseTestDataMain.next, sut.next)
    }

    func testAltValuesIsAltValues() {
        sut = ListResponse.alt()
        XCTAssertEqual(ListResponseTestDataAlt.count, sut.count)
        XCTAssertEqual(ListResponseTestDataAlt.results, sut.results)
        XCTAssertEqual(ListResponseTestDataAlt.previous, sut.previous)
        XCTAssertEqual(ListResponseTestDataAlt.next, sut.next)
    }
}

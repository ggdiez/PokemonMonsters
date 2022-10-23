//
//  PokemonRepositoryTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//


import XCTest
import Combine
@testable import PokemonMonsters

class PokemonRepositoryTest: XCTestCase {
    // MARK: - Test variables
    var sut: PokemonRepository!
    var apiClient: PokemonAPIClientMock!
    var urlPath = "https://www.apple.com/"


    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        super.setUp()
        apiClient = PokemonAPIClientMock()
        sut = PokemonRepository(apiClient: apiClient)
    }

    override func tearDownWithError() throws {
        sut = nil
        apiClient = nil
        super.tearDown()
    }
    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testCreateInvokesCompletionHandler() {
        let expectation = XCTestExpectation(description: "Get Pokemon Detail async")
        guard let url = URL(string: urlPath) else {
            return
        }
        var handlerInvoked = 0

        let cancellable = sut.getPokemonDetail(url: url)
            .sink { _ in } receiveValue: { pokemon in
                handlerInvoked += 1
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(1, handlerInvoked)
        cancellable.cancel()
    }

    func testSutReceivePropertyValue () {
        let expectation = XCTestExpectation(description: "Get Pokemon Detail async")
        let expectedValue = PokemonDetail.main()
        var pokemonReceived: PokemonDetail?

        guard let url = URL(string: urlPath) else {
            return
        }

        let cancellable = sut.getPokemonDetail(url: url)
            .sink { _ in } receiveValue: { pokemon in
                pokemonReceived = pokemon
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(expectedValue, pokemonReceived)
        cancellable.cancel()
    }

    // MARK: Test doubles
    class PokemonAPIClientMock: PokemonAPIClientProtocol {
        var error: PokemonGatewayError?
        func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError> {
            if error != nil {
                return Fail(error: error ?? PokemonGatewayError.unaccessible).eraseToAnyPublisher()
            } else {
                return Just(PokemonDetail.main()).delay(for: 2, scheduler: RunLoop.main).setFailureType(to: PokemonGatewayError.self).eraseToAnyPublisher()
            }
        }
    }
}

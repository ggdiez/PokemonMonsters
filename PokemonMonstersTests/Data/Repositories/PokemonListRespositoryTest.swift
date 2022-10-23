//
//  PokemonListRespositoryTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
import Combine
@testable import PokemonMonsters

class PokemonListRepositoryTest: XCTestCase {
    // MARK: - Test variables
    var sut: PokemonListRepository!
    var apiClient: PokemonAPIClientMock!
    var initialURL = URL(string: "https://www.apple.com/")

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        super.setUp()

        guard let initialURL = initialURL else {
            return
        }
        apiClient = PokemonAPIClientMock()
        sut = PokemonListRepository(initialURL: initialURL, apiClient: apiClient)
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
        let expectation = XCTestExpectation(description: "Get Pokemons  async")

        var handlerInvoked = 0

        let cancellable = sut.getPokemons()
            .sink { _ in } receiveValue: { list in
                handlerInvoked += 1
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(1, handlerInvoked)
        cancellable.cancel()
    }

    func testSutReceivePropertyValue() {
        let expectation = XCTestExpectation(description: "Get Pokemons  async")

        let expectedValue = [Pokemon.main(), Pokemon.alt()]
        var valueReceived: [Pokemon]?

        let cancellable = sut.getPokemons()
            .sink { _ in } receiveValue: { pokemons in
                valueReceived = pokemons
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(valueReceived, expectedValue)
        cancellable.cancel()
    }

    // MARK: Test doubles
    class PokemonAPIClientMock: PokemonListAPIClientProtocol {
        var error: PokemonListGatewayError?
        func getPokemonList(url: URL) -> AnyPublisher<ListResponse, PokemonListGatewayError> {
            if error != nil {
                return Fail(error: error ?? PokemonListGatewayError.unaccessible).eraseToAnyPublisher()
            } else {
                return Just(ListResponse.main()).delay(for: 2.0, scheduler: RunLoop.main).setFailureType(to: PokemonListGatewayError.self).eraseToAnyPublisher()
            }
        }
    }
}


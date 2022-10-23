//
//  PokemonListUseCaseTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
import Combine
@testable import PokemonMonsters

class PokemonListUseCaseTest: XCTestCase {

    // MARK: - Test variables
    var sut: PokemonListUseCase!
    var entityGateway: EntityGatewayMock!
    var isSuccess: Bool = false
    var error: DomainError?

    override func setUpWithError() throws {
        super.setUp()
        entityGateway = EntityGatewayMock()
        sut = PokemonListUseCase(entityGateway: entityGateway, handler: { [weak self] result in
            switch result {
            case .success:
                self?.isSuccess =  true
            case let.failure(error):
                self?.error = error
            }
        })
    }

    override func tearDownWithError() throws {
        sut = nil
        entityGateway = nil
    }

    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testReportsSuccess() {
        entityGateway.error = nil
        sut.execute()

        XCTAssertTrue(isSuccess)
    }

    func testReportsNotSuccess() {
        entityGateway.error = .unaccessible
        sut.execute()

        XCTAssertFalse(isSuccess)
    }

    func testReportsUnaccessibleErrorFromEntityGateway() {
        entityGateway.error = PokemonListGatewayError.unaccessible
        sut.execute()

        XCTAssertEqual(DomainError.unaccessible, error)
    }

    // MARK: - Mock
    class EntityGatewayMock: PokemonListGatewayTestDummy {
        var error: PokemonListGatewayError?
        override func getPokemons() -> AnyPublisher<[Pokemon], PokemonListGatewayError> {
            if error != nil {
                return Fail(error: error ?? PokemonListGatewayError.unaccessible).eraseToAnyPublisher()
            } else {
                return Just([]).setFailureType(to: PokemonListGatewayError.self).eraseToAnyPublisher()
            }
        }
    }
}


//
//  PokemonDetailUseCaseTest.swift
//  PokemonMonstersTests
//
//  Created by Gonzalo  on 29/8/22.
//

import XCTest
import Combine
@testable import PokemonMonsters

class PokemonDetailUseCaseTest: XCTestCase {

    // MARK: - Test variables
    var sut: PokemonDetailUseCase!
    var entityGateway: EntityGatewayMock!
    var url = URL("https://www.apple.com/")
    var isSuccess: Bool = false
    var error: DomainError?

    override func setUpWithError() throws {
        super.setUp()
        entityGateway = EntityGatewayMock()

        sut = PokemonDetailUseCase(entityGateway: entityGateway, url: url, handler: { [weak self] result in
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
        isSuccess = false
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
        entityGateway.error = PokemonGatewayError.unaccessible
        sut.execute()

        XCTAssertEqual(DomainError.unaccessible, error)
    }

    // MARK: - Mock
    class EntityGatewayMock: PokemonGatewayTestDummy {
        var error: PokemonGatewayError?
        override func getPokemonDetail(url: URL) -> AnyPublisher<PokemonDetail, PokemonGatewayError> {
            if error != nil {
                return Fail(error: error ?? PokemonGatewayError.unaccessible).eraseToAnyPublisher()
            } else {
                return Just(PokemonDetail.main()).setFailureType(to: PokemonGatewayError.self).eraseToAnyPublisher()
            }
        }
    }
}



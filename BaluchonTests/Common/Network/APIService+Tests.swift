//
//  APIService+Tests.swift
//  BaluchonTests
//
//  Created by fred on 10/01/2022.
//

import XCTest
@testable import Baluchon

class APIService_Tests: TestCase {

    var sut: APIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = APIService(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    override func tearDown() {
            TestURLProtocol.loadingHandler = nil
        }

    let stubUrl = URL(string: "https://ep.com")

    var session: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    func test_given_correctJson_when_fetching_rate_then_succed() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubbedResponseOK(from: "rates")
        let promise = expectation(description: "Loading")
        
        // act
        sut.getData(request: url, dataType: RateData.self) { (result) in

        // assert
            switch result {
                case .failure(let error):
                    XCTFail("Request was not successful: \(error.localizedDescription)")
                case .success(let rate):
                XCTAssertEqual(rate.USD, 1.137145)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }

    func test_given_badjson_when_fetching_then_failed_invalidData() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubbedResponseBad(from: "badjson")
        let promise = expectation(description: "Loading")
        
        // act
        sut.getData(request: url, dataType: WeatherData.self) { (result) in

        // assert
            switch result {
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        XCTAssertEqual(error.localizedDescription, "Les données reçues ne sont pas conformes")
                    default:
                        XCTFail("Request was not successful: \(error.localizedDescription)")
                    }
                case .success(_):
                    XCTFail("Request did not fail when it was expected to.")
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }

    func test_given_404_when_fetching_translate_then_failed_with_statusCode_404() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubbedResponse404(from: "badjson")
        let promise = expectation(description: "Loading")
        
        // act
        sut.getData(request: url, dataType: RateData.self) { (result) in

        // assert
            switch result {
                case .failure(let error):
                    switch error {
                    case .response(let code):
                        XCTAssertEqual(code, 404)
                        XCTAssertEqual(error.localizedDescription, "Donnée non trouvée, erreur 404.\n\n Vérifier la langue ou l'orthographe.\n Exemple pour Pointe à Pitre,\n saisir pointe-a-pitre")
                    default:
                        XCTFail("Request was not successful: \(error.localizedDescription)")
                    }
                case .success(_):
                    XCTFail("Request did not fail when it was expected to.")
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }

    func test_given_badresponse_when_fetching_translate_then_failed_with_error() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubbedError(from: "badjson", statusCode: 500)
        let expectation = XCTestExpectation(description: "Loading")
        
        // act
        sut.getData(request: url, dataType: TranslationData.self) { (result) in

        // assert
            switch result {
            case .failure(let error):
                switch error {
                case .connexion(_):
                    XCTAssertEqual(error.localizedDescription,"La connexion Internet semble être hors ligne.")
                case .unknow:
                    XCTAssertEqual(error.localizedDescription, "Une erreur est survenue")
                default:
                    XCTFail("Request was not successful: \(error.localizedDescription)")
                }
            case .success(_):
                XCTFail("Request did not fail when it was expected to.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

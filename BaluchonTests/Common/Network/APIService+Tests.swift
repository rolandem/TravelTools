//
//  APIService+Tests.swift
//  BaluchonTests
//
//  Created by fred on 10/01/2022.
//

import XCTest
@testable import Baluchon

class APIService_Tests: TestCase {  

    override func tearDown() {
            TestURLProtocol.loadingHandler = nil
        }

    let stubUrl = URL(string: "https://ep.com")

    var session: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    func test_when_fetching_rate_then_succed() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubRequest(from: "rates", statusCode: 200)

        // act
        let expectation = XCTestExpectation(description: "Loading")
        let task = APIService(session: session)

        // assert
        task.getData(request: url, dataType: Rate.self) { (result) in
            switch result {
                case .failure(let error):
                    XCTFail("Request was not successful: \(error.localizedDescription)")
                case .success(let rate):
                XCTAssertEqual(rate.USD, 1.137145)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_when_fetching_badjson_then_failed_invalidData() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubRequest(from: "badjson", statusCode: 204)

        // act
        let expectation = XCTestExpectation(description: "Loading")
        let task = APIService(session: session)

        // assert
        task.getData(request: url, dataType: Rate.self) { (result) in
            switch result {
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        XCTAssertNotNil(error)
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

    func test_when_fetching_translate_then_failed_with_response_statusCode_404() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubRequest(from: "badjson", statusCode: 404)

        // act
        let expectation = XCTestExpectation(description: "Loading")
        let task = APIService(session: session)

        // assert
        task.getData(request: url, dataType: Rate.self) { (result) in
            switch result {
                case .failure(let error):
                    switch error {
                    case .response(let code):
                        XCTAssertEqual(code, 404)
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

    func test_when_fetching_translate_then_failed_with_error() {
        // arrange
        guard let url = stubUrl else { return }
        TestURLProtocol.loadingHandler = TestCase.stubRequestError(from: "translate", statusCode: 500)

        // act
        let expectation = XCTestExpectation(description: "Loading")
        let task = APIService(session: session)

        // assert
        task.getData(request: url, dataType: Translation.self) { (result) in
            switch result {
            case .failure(let error):
                switch error {
                case .connexion(let error):
                    XCTAssertNotNil(error)
                case .unknown:
                    XCTAssertNotNil(error)
                default: break
                }
            case .success(_):
                XCTFail("Request did not fail when it was expected to.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}

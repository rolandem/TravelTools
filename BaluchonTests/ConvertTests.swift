//
//  ConvertTests.swift
//  BaluchonTests
//
//  Created by fred on 05/01/2022.
//

import XCTest
@testable import Baluchon

class ConvertTests: XCTestCase {

    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }
        
        struct TestExchangeRate: Codable, Equatable {
            var USD: Double
        }

    func testFetchingDataSuccessfully() {
        // Given
        let expected = TestExchangeRate(USD: 1.13)
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        let responseJSONData = try! JSONEncoder().encode(expected)
        TestURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, responseJSONData, nil)
        }
        // When
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let task = TaskService()
        let session = URLSession(configuration: configuration)
        // Then
        task.taskData(urlSession: session,
                      request: request.url!,
                      requestDataType: TestExchangeRate.self) { (result) in
            switch result {
                case .failure(let error):
                    XCTFail("Request was not successful: \(error.localizedDescription)")
                case .success(let exchangeRate):
                    XCTAssertEqual(exchangeRate, expected)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func test404Failure() {
        // Given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        TestURLProtocol.loadingHandler = { request in
                let response = HTTPURLResponse(url: request.url!,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)!
                return (response, Data(), nil)
        }
        // When
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let task = TaskService()
        let session = URLSession(configuration: configuration)
        // Then
        task.taskData(urlSession: session,
                      request: request.url!,
                      requestDataType: TestExchangeRate.self) { (result) in
            switch result {
                case .failure(let error):
                    switch error {
                    case .response(let code):
                        XCTAssertEqual(code, 404)
                    default:
                        XCTFail("Unexpected loading error.")
                    }
                case .success(_):
                    XCTFail("Request did not fail when it was expected to.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testFetchingDataFailed() {
        // Given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        TestURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 204,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data(), nil)
        }
        // When
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let task = TaskService()
        let session = URLSession(configuration: configuration)
        // Then
        task.taskData(urlSession: session,
                      request: request.url!,
                      requestDataType: TestExchangeRate.self) { (result) in
            switch result {
                case .failure(let error):
                    switch error {
                    case .invalidData(let jsonError):
                        XCTAssertEqual(jsonError.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
                    default:
                        XCTFail("Unexpected loading error.")
                    }
                case .success(_):
                XCTFail("Request did not fail when it was expected to.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testConnexionOff() {
        // Given
        
        // When
        
        // Then
        
    }

//    func testConvertRequest() {
//        // Given
//        let expected = TestExchangeRate(USD: 1.13)
//        //let request = URLRequest(url: URL(string: "https://www.example.com")!)
//        let responseJSONData = try! JSONEncoder().encode(expected)
//        TestURLProtocol.loadingHandler = { request in
//            let response = HTTPURLResponse(url: request.url!,
//                                           statusCode: 200,
//                                           httpVersion: nil,
//                                           headerFields: nil)!
//            return (response, responseJSONData, nil)
//        }
//        // When
//        let expectation = XCTestExpectation(description: "Loading")
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [TestURLProtocol.self]
//        let session = URLSession(configuration: configuration)
//        let convert = ConvertRequest(rateSession: session)
//
//        // Then
//        convert.getRate(requestDataType: TestExchangeRate.self) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("Request was not successful: \(error.localizedDescription)")
//            case .success(let responseJSONData):
//                XCTAssertEqual(responseJSONData, expected)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.1)
//    }

}

class TestURLProtocol: URLProtocol {
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?
        
        override func startLoading() {
            guard let handler = TestURLProtocol.loadingHandler else {
                XCTFail("Loading handler is not set.")
                return
            }
            let (response, data, error) = handler(request)
            if let data = data {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            }
            else {
                client?.urlProtocol(self, didFailWithError: error!)
            }
        }
        override func stopLoading() {
        }

}

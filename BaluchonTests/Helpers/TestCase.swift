//
//  TestCase.swift
//  BaluchonTests
//
//  Created by fred on 07/01/2022.
//

import XCTest
@testable import Baluchon

class TestCase: XCTestCase {

    // MARK: - Data

    static func stubbedData( from json: String) -> Data? {
        let bundle = Bundle(for: TestCase.self)
        let url = bundle.url(forResource: json, withExtension: "json") ?? URL(fileURLWithPath: "www")
        return try? Data(contentsOf: url)
    }

    // MARK: - Url
    
    static func stubbedUrl( from json: String) -> URL? {
        let bundle = Bundle(for: TestCase.self)
        let url = bundle.url(forResource: json, withExtension: "json") ?? URL(fileURLWithPath: "www")
        return url
    }

    // MARK: - Correct and Wrong Response

    static func stubbedResponseOK(from json: String) -> ((URLRequest) -> (HTTPURLResponse, Data?, Error?))? {
        let stubData = stubbedData(from: json)
        var data: Data?
        if stubData == nil {
            data = Data()
        } else {
            data = stubData
        }
        var request = BaluchonTests.TestURLProtocol.loadingHandler
        request = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data, nil)
        }
        return request
    }

    static func stubbedResponseBad(from json: String) -> ((URLRequest) -> (HTTPURLResponse, Data?, Error?))? {
        let stubData = stubbedData(from: json)
        var data: Data?
        if stubData == nil {
            data = Data()
        } else {
            data = stubData
        }
        var request = BaluchonTests.TestURLProtocol.loadingHandler
        request = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 204,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data, nil)
        }
        return request
    }

    static func stubbedResponse404(from json: String) -> ((URLRequest) -> (HTTPURLResponse, Data?, Error?))? {
        let stubData = stubbedData(from: json)
        var data: Data?
        if stubData == nil {
            data = Data()
        } else {
            data = stubData
        }
        var request = BaluchonTests.TestURLProtocol.loadingHandler
        request = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data, nil)
        }
        return request
    }

    static func stubbedError(
        from json: String,
        statusCode: Int
    ) -> ((URLRequest) -> (HTTPURLResponse, Data?, Error?))? {

        var request = BaluchonTests.TestURLProtocol.loadingHandler
        request = { request in
            let response = HTTPURLResponse()
            return (response, nil, error)
        }
        return request
    }
    
    //MARK: - Error

    class RequestError: Error{}
    static let error = RequestError()
    
}

final class TestURLProtocol: URLProtocol {
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

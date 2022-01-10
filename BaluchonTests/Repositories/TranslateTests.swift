//
//  TranslateTests.swift
//  BaluchonTests
//
//  Created by fred on 06/01/2022.
//

import XCTest
@testable import Baluchon

class TranslateTests: XCTestCase {

    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
        }

    struct TestTranslationResponse: Codable, Equatable {
        var translatedText: String
    }

//    func testTranslaterequest() {
//        // given
//        let inputText = "bonjour"
//        let sourceLang = "fr"
//        let targetLang = "en"
//
//        let expected = TestTranslationResponse(translatedText: "hello")
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
//        let translation = TranslateRequest(translateSession: session)
//        //let result: Result<TestTranslationResponse, TaskService.FetchError>
//
//        // Then
//        translation.getTranslation(inputText: inputText,
//                                   sourceLang: sourceLang,
//                                   targetLang: targetLang) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("Request was not successful: \(error.localizedDescription)")
//            case .success(let responseJSONData):
//                let response = responseJSONData.translatedText
//                XCTAssertEqual(response, "hello")
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1)
//    }
    
}

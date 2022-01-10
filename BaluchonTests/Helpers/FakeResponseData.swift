//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by fred on 02/01/2022.
//

import Foundation

class FakeResponseData {

    //MARK: - Rates Data

        static var fakeRatesCorrectData: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "rates", withExtension: "json")!
            return try! Data(contentsOf: url)
        }

        static let fakeRatesIncorrectData = "cloud".data(using: .utf8)!

    //MARK: - Weather Data

        static var fakeWeatherCorrectData: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "weather", withExtension: "json")!
            return try! Data(contentsOf: url)
        }

        static let fakeWeatherIncorrectData = "verglas".data(using: .utf8)!

    //MARK: - Translate Data

        static var fakeTranslateCorrectData: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "translate", withExtension: "json")!
            return try! Data(contentsOf: url)
        }

        static let faketranslateIncorrectData = "charabiat".data(using: .utf8)!

    //MARK: - Response

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://ep.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://ep.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    //MARK: - Error

        class RequestError: Error{}
        static let error = RequestError()
}

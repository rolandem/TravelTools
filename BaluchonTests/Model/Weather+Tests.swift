//
//  Weather+Tests.swift
//  BaluchonTests
//
//  Created by fred on 10/01/2022.
//

import XCTest
@testable import Baluchon

class Weather_Tests: TestCase {

    func testWeatherJsonMapping() throws {
        // arrange
        guard let dataWeather = TestCase.stubbedData(from: "weather") else { return }
        // act
        let decoder = JSONDecoder()
        let weather = try decoder.decode(Weather.self, from: dataWeather)
        // assert
        XCTAssertEqual(weather.description, "nuageux")
    }

}

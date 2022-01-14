//
//  WeatherAPI+Tests.swift
//  BaluchonTests
//
//  Created by fred on 14/01/2022.
//

import XCTest
@testable import Baluchon

class WeatherAPI_Tests: XCTestCase {

    var sut: WeatherAPI!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherAPI(apiKey: "")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_weather_url() throws {
        // arrange
        let location = "tokyo"
        // assert
        XCTAssertEqual(sut.getUrl(location: location), URL(string: "http://api.openweathermap.org/data/2.5/weather?q=tokyo&units=metric&lang=fr&appid="))
    }
}

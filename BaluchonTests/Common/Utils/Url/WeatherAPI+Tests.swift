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
        let urlShouldBe = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=tokyo&units=metric&lang=fr&appid=")
        // assert
        XCTAssertEqual(sut.buildUrl(location: location), urlShouldBe)
    }

    func test_given_empty_text_when_getUrl_then_url_valid() {
        // arrange
        let location = ""
        let urlShouldBe = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=&units=metric&lang=fr&appid=")
        
        // act
        let result = sut.buildUrl(location: location)
        
        // assert
        XCTAssertEqual(result, urlShouldBe)
    }

    func test_given_whitespace_when_getUrl_then_e() {
        // arrange
        let location = " "
        let urlShouldBe = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=%20&units=metric&lang=fr&appid=")
        
        // act
        let result = sut.buildUrl(location: location)
        
        // assert
        XCTAssertEqual(result, urlShouldBe)
    }
}

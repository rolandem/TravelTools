//
//  WeatherRepository+Tests.swift
//  BaluchonTests
//
//  Created by fred on 21/01/2022.
//

import XCTest
@testable import Baluchon

class WeatherRepository_Tests: XCTestCase {

    var sut: WeatherRepository?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherRepository(apiKey: "ghijkl")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_build_weatherUrl() throws {
        // arrange
        let location = "Berlin"
        let urlShouldBe = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Berlin&units=metric&lang=fr&appid=ghijkl")

        // assert
        XCTAssertEqual(sut?.getUrl(location: location), urlShouldBe)
    }

    func test_given_empty_text_when_getUrl_then_url_valid() {
        // arrange
        let location = ""
        let urlShouldBe = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=&units=metric&lang=fr&appid=ghijkl")

        // act
        let result = sut?.getUrl(location: location)

        // assert
        XCTAssertEqual(result, urlShouldBe)
    }

    func test_given_whitespace_when_getUrl_then_url_valid() {
        // arrange
        let location = " "
        let urlShouldBe = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=%20&units=metric&lang=fr&appid=ghijkl")

        // act
        let result = sut?.getUrl(location: location)

        // assert
        XCTAssertEqual(result, urlShouldBe)
    }
}

//
//  WeatherController+Tests.swift
//  BaluchonTests
//
//  Created by fred on 16/01/2022.
//

import XCTest
@testable import Baluchon

class WeatherController_Tests: XCTestCase {

    var sut: WeatherController?

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "WeatherController", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherController") as? WeatherController
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_given_keyboard_displayed_when_clic_return_then_keyboard_dismiss() throws {
        // arrange
        guard let research = sut?.research else { return }
        research.becomeFirstResponder()

        // act
        if ((sut?.textFieldShouldReturn(research)) != nil) {

        // assert
            XCTAssertFalse(research.isFirstResponder)

        }
    }

    func test_given_WeatherData_when_get_then_setup_view() throws {
        // arrange
        guard let location = sut?.localWeather else { return }

        guard let dataWeather = TestCase.stubbedData(from: "weather") else { return }
        let decoder = JSONDecoder()
        let weather = try decoder.decode(Weather.self, from: dataWeather)

        // act
        sut?.setupWeatherView(with: weather, from: location)
        let temperature = weather.temperature.withoutDecimal()
        // assert
        XCTAssertEqual(location.cityName.text, "Londres")
        XCTAssertEqual(location.countryName.text, "GB")
        XCTAssertEqual(location.temperature.text, "\(temperature) °C")
    }
}

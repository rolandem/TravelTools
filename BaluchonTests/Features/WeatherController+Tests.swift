//
//  WeatherController+Tests.swift
//  BaluchonTests
//
//  Created by fred on 16/01/2022.
//

import XCTest
@testable import Baluchon

class WeatherController_Tests: XCTestCase {

    var sut: WeatherController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "WeatherController", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherController") as? WeatherController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_given_keyboard_displayed_when_clic_return_then_keyboard_dismiss() {
        // arrange
        guard let research = sut.research else { return }
        research.becomeFirstResponder()

        // act
        if sut.textFieldShouldReturn(research) {

        // assert
            XCTAssertFalse(research.isFirstResponder)
        
        }
    }
}

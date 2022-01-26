//
//  WeatherController+UITests.swift
//  BaluchonUITests
//
//  Created by fred on 18/01/2022.
//

import XCTest
@testable import Baluchon

class WeatherController_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testVideoBackgroundExists() throws {

        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Météo"].tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()

        let video = app.windows.element

        XCTAssertTrue(video.exists)

        app.textFields["destination"].tap()
        app.buttons["ok"].tap()
        app.alerts["Oups..."].scrollViews.otherElements.buttons["Ok"].tap()

        let alert = app.alerts["Oups..."].staticTexts["Mauvais message"]

        XCTAssertFalse(alert.exists)
    }
}

//
//  TranslateController+UITests.swift
//  BaluchonUITests
//
//  Created by fred on 16/01/2022.
//

import XCTest
@testable import Baluchon

class TranslateController_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testChangeOriginalLanguage() throws {

        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Traduction"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Français"]/*[[".buttons[\"Français\"].staticTexts[\"Français\"]",".staticTexts[\"Français\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Croate"]/*[[".cells.staticTexts[\"Croate\"]",".staticTexts[\"Croate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Grec"]/*[[".cells.staticTexts[\"Grec\"]",".staticTexts[\"Grec\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let titleButton = app.buttons["Grec"].staticTexts["Grec"]

        XCTAssertTrue(titleButton.exists)
    }

    func testChangetranslatedLanguage() throws {

        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Traduction"].tap()
        app.staticTexts["Anglais"].tap()

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Croate"]/*[[".cells.staticTexts[\"Croate\"]",".staticTexts[\"Croate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery.staticTexts["Croate"].tap()

        let titleButton = app.buttons["Croate"].staticTexts["Croate"]

        XCTAssertTrue(titleButton.exists)
    }
}

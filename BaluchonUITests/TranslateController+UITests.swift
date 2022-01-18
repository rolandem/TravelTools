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
        app.tabBars["Tab Bar"].buttons["Translate"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Français"]/*[[".buttons[\"Français\"].staticTexts[\"Français\"]",".staticTexts[\"Français\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Croate"]/*[[".cells.staticTexts[\"Croate\"]",".staticTexts[\"Croate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Grec"]/*[[".cells.staticTexts[\"Grec\"]",".staticTexts[\"Grec\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let titleButton = app.buttons["Grec"].staticTexts["Grec"]

        XCTAssertTrue(titleButton.exists)
    }

    func testChangetranslatedLanguage() throws {
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Translate"].tap()
        app.staticTexts["Anglais"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Croate"]/*[[".cells.staticTexts[\"Croate\"]",".staticTexts[\"Croate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery.staticTexts["Croate"].tap()
        
        let titleButton = app.buttons["Croate"].staticTexts["Croate"]
        
        XCTAssertTrue(titleButton.exists)
    }

    func testTranslate() throws {
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Translate"].tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["B"]/*[[".keyboards.keys[\"B\"]",".keys[\"B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        
        let jKey = app/*@START_MENU_TOKEN@*/.keys["j"]/*[[".keyboards.keys[\"j\"]",".keys[\"j\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        jKey.tap()
        
        oKey.tap()
        
        let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Traduire"].staticTexts["Traduire"]/*[[".buttons[\"Traduire\"].staticTexts[\"Traduire\"]",".staticTexts[\"Traduire\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        let result = app.staticTexts["Hello"]
        XCTAssertTrue(result.exists)
    }
}

//
//  ConvertController+UITests.swift
//  BaluchonUITests
//
//  Created by fred on 18/01/2022.
//

import XCTest
@testable import Baluchon

class ConvertController_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testResultConvert() throws {
        
        let app = XCUIApplication()
        
        let montantConvertirTextField = app.textFields["Montant à convertir"]
        montantConvertirTextField.tap()
    
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        app.buttons["arrowDown 20"].tap()
        let result = app.staticTexts["1,14"]
        XCTAssertTrue(result.exists)
    }

}

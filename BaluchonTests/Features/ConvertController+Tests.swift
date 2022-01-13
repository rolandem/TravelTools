//
//  ConvertController+Tests.swift
//  BaluchonTests
//
//  Created by fred on 13/01/2022.
//

import XCTest
@testable import Baluchon

class ConvertController_Tests: XCTestCase {

    var sut: ConvertController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "ConvertController", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "ConvertController") as? ConvertController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_given_switchIconDeviceButton_when_pressed_then_iconsDevices_swap() {

        // arrange
        guard let originalIcon = sut.originIcon.text,
              let convertedIcon = sut.convertedIcon.text,
              let button = sut.switchButton
        else { return }

        let originDevice = sut.originDevice
        let convertedDevice = sut.convertedDevice

        // act
        sut.switchIconDevice(button)

        // assert
        XCTAssertEqual(originalIcon, originDevice)
        XCTAssertEqual(convertedIcon, convertedDevice)
            
        }

    func test_Given_originDevice_when_convertButton_pressed_then_displays_result() {

        // arrange
        guard let convertToButton = sut.convertToButton,
              var amountText = sut.amountField.text
        else { return }
        amountText = "12"
        guard let amount = Double(amountText) else { return }

        var rate = sut.defaults.double(forKey: "usdrate")
        rate = 1.13

         var resultText = sut.resultAmount.text

        // act
        sut.convertButton(convertToButton)

        // assert
        if sut.originIcon.text == "€" {
            let result = amount * rate
            resultText = result.withDecimal()
            XCTAssertEqual(resultText, "13.56")
        } else if sut.originIcon.text == "$" {
            let result = amount * (1/rate)
            resultText = result.withDecimal()
            XCTAssertEqual(resultText, "10.62")
        }
    }

    func test_given_keyboard_displayed_when_clic_return_then_keyboard_dismiss() {
        // arrange
        guard let amountText = sut.amountField else { return }
        amountText.becomeFirstResponder()
        // act
        if sut.textFieldShouldReturn(amountText) {
         
        // assert
            XCTAssertFalse(amountText.isFirstResponder)
            
        }
    }

    

}

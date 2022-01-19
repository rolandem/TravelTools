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

    func test_given_switchIconDeviceButton_when_pressed_then_iconsDevices_swap() throws {

        // arrange
        guard let originalIcon = sut.originIcon.text,
              let convertedIcon = sut.convertedIcon.text,
              let button = sut.switchButton
        else { return }

        let originDevice = sut.originCurrency
        let convertedDevice = sut.convertedCurrency

        // act
        sut.switchIconCurrency(button)

        // assert
        XCTAssertEqual(originalIcon, originDevice)
        XCTAssertEqual(convertedIcon, convertedDevice)
    }

    func test_given_keyboard_displayed_when_clic_return_then_keyboard_dismiss() throws {
        // arrange
        guard let amountText = sut.amountField else { return }
        amountText.becomeFirstResponder()

        // act
        if sut.textFieldShouldReturn(amountText) {

        // assert
            XCTAssertFalse(amountText.isFirstResponder)
        }
    }

    func test_given_convertButton_when_pressed_then_resignFirstResponder() throws {
        // arrange
        guard let button = sut.convertToButton,
              let amount = sut.amountField
        else { return }
        amount.becomeFirstResponder()

        // act
        sut.convertButton(button)

        // assert
        XCTAssertFalse(amount.resignFirstResponder())
    }
}

//
//  ConvertControl+Tests.swift
//  BaluchonTests
//
//  Created by fred on 15/01/2022.
//

import XCTest
@testable import Baluchon

class ConvertControl_Tests: XCTestCase {

    var sut: ConvertControl!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ConvertControl()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_convert_euro_amount() throws {
        // arrange
        let testAmount = "12"
        guard let amount = Double(testAmount) else { return }
        let originIcon = "€"
        let rate = sut.rate /// recovering last rate
        let convertedAmountShouldBe = String((amount * rate).withDecimal()).replaceDot()
        
        // act
        let convertedAmount = sut.getConvertedAmount(with: testAmount, originIcon: originIcon)
        
        // assert
        XCTAssertEqual(convertedAmountShouldBe, convertedAmount)
    }

    func test_convert_dollar_amount() throws {
        // arrange
        let testAmount = "56"
        guard let amount = Double(testAmount) else { return }
        let originIcon = "$"
        let rate = sut.rate /// recovering last rate
        let convertedAmountShouldBe = String((amount * (1/rate)).withDecimal()).replaceDot()
        
        // act
        let convertedAmount = sut.getConvertedAmount(with: testAmount, originIcon: originIcon)
        
        // assert
        XCTAssertEqual(convertedAmountShouldBe, convertedAmount)
    }

    func test_convert_dollar_amount_with_comma() throws {
        // arrange
        let testAmount = "13,5"
        guard let amount = Double(testAmount.replaceComma()) else { return }
        let originIcon = "$"
        let rate = sut.rate /// recovering last rate
        let convertedAmountShouldBe = String((amount * (1/rate)).withDecimal()).replaceDot()
        
        // act
        let convertedAmount = sut.getConvertedAmount(with: testAmount, originIcon: originIcon)
        
        // assert
        XCTAssertEqual(convertedAmountShouldBe, convertedAmount)
    }

    func test_convert_dollar_amount_with_several_commas() throws {
        // arrange
        let testAmount = "13,5,0"
        let originIcon = "$"
        let convertedAmountShouldBe = " "
        
        // act
        let convertedAmount = sut.getConvertedAmount(with: testAmount, originIcon: originIcon)
        
        // assert
        XCTAssertEqual(convertedAmountShouldBe, convertedAmount)
    }

    func test_convert_null_euro_amount() throws {
        // arrange
        let testAmount = " "
        let originIcon = "€"
        let convertedAmountShouldBe = " "
        
        // act
        let convertedAmount = sut.getConvertedAmount(with: testAmount, originIcon: originIcon)
        
        // assert
        XCTAssertEqual(convertedAmountShouldBe, convertedAmount)
    }
}

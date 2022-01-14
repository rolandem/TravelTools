//
//  ConvertAPI+Tests.swift
//  BaluchonTests
//
//  Created by fred on 14/01/2022.
//

import XCTest
@testable import Baluchon

class ConvertAPI_Tests: XCTestCase {

    var sut: ConvertAPI!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ConvertAPI()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_convert_url() throws {
        // arrange
        sut.apiKey = "abcdef"
        
        // asset
        XCTAssertEqual(sut.convertUrl, URL(string: "http://data.fixer.io/api/latest?access_key=abcdef"))
    }
}

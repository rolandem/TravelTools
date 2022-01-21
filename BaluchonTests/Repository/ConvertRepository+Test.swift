//
//  ConvertRepository+Test.swift
//  BaluchonTests
//
//  Created by fred on 21/01/2022.
//

import XCTest
@testable import Baluchon

class ConvertRepository_Test: XCTestCase {

    var sut: ConvertRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ConvertRepository(apiKey: "abcdef")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_build_convertUrl() throws {
        // arrange
        let urlShoudBe = URL(string: "http://data.fixer.io/api/latest?access_key=abcdef")
        // assert
        XCTAssertEqual(sut.getUrl, urlShoudBe)
    }
}

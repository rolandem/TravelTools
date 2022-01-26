//
//  TranslateRepository.swift
//  BaluchonTests
//
//  Created by fred on 20/01/2022.
//

import XCTest
@testable import Baluchon

class TranslateRepository_Tests: XCTestCase {

    var sut: TranslateRepository?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TranslateRepository(apiKey: "")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_build_translateUrl() throws {
        // arrange
        let inputText = "essai"
        let source = "fr"
        let target = "en"
        let urlShouldBe = URL(string: "https://translation.googleapis.com/language/translate/v2?q=essai&source=fr&target=en&format=text&key=")
        // assert
        XCTAssertEqual(sut?.getUrl(inputText: inputText, sourceLang: source, targetLang: target), urlShouldBe)
    }
}

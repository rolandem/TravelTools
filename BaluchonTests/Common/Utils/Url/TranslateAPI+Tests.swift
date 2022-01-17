//
//  TranslateAPI+Tests.swift
//  BaluchonTests
//
//  Created by fred on 14/01/2022.
//

import XCTest
@testable import Baluchon

class TranslateAPI_Tests: XCTestCase {

    var sut: TranslateAPI!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TranslateAPI(apiKey: "")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_given_text_when_translate_then_url_good() throws {
        // arrange
        let inputText = "essai traduction"
        let sourceLang = "fr"
        let targetLang = "en"
        
        // assert
        XCTAssertEqual(sut.getUrl(inputText: inputText, sourceLang: sourceLang, targetLang: targetLang), URL(string: "https://translation.googleapis.com/language/translate/v2?q=essai%20traduction&source=fr&target=en&format=text&key="))
    }

    func test_given_text_empty_when_translate_then_url_valid() throws {
        // arrange
        let inputText = ""
        let sourceLang = "fr"
        let targetLang = "en"
        
        // assert
        XCTAssertEqual(sut.getUrl(inputText: inputText, sourceLang: sourceLang, targetLang: targetLang), URL(string: "https://translation.googleapis.com/language/translate/v2?q=&source=fr&target=en&format=text&key="))
    }

    func test_given_whitespace_when_translate_then_url_valid() throws {
        // arrange
        let inputText = "     "
        let sourceLang = "fr"
        let targetLang = "en"
        
        // assert
        XCTAssertEqual(sut.getUrl(inputText: inputText, sourceLang: sourceLang, targetLang: targetLang), URL(string: "https://translation.googleapis.com/language/translate/v2?q=%20%20%20%20%20&source=fr&target=en&format=text&key="))
    }
}

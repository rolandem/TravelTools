//
//  Translation+Tests.swift
//  BaluchonTests
//
//  Created by fred on 10/01/2022.
//

import XCTest
@testable import Baluchon

class Translation_Tests: XCTestCase {

    func testTranslateJsonMapping() throws {
        // arrange
        guard let dataTranslate = TestCase.stubbedData(from: "translate") else { return }
        // act
        let decoder = JSONDecoder()
        let translation = try decoder.decode(Translation.self, from: dataTranslate)
        // assert
        XCTAssertEqual(translation.translatedText, "welcome to berlin")
    }
}

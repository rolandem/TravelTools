//
//  Rate+Tests.swift
//  BaluchonTests
//
//  Created by fred on 10/01/2022.
//

import XCTest
@testable import Baluchon

class Rate_Tests: XCTestCase {

    func testRateJsonMapping() throws {
        // arrange
        guard let dataRate = FakeResponseData.fakeRatesCorrectData else { return }
        // act
        let decoder = JSONDecoder()
        let rate = try decoder.decode(Rate.self, from: dataRate)
        // assert
        XCTAssertEqual(rate.USD, 1.137145)
    }

    
}

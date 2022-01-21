//
//  Persistent+Tests.swift
//  BaluchonTests
//
//  Created by fred on 21/01/2022.
//

import XCTest
@testable import Baluchon

class Persistent_Tests: XCTestCase {

    var sut:Persistent!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Persistent.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_recover_and_save_persistent_data() {
        let currentRate = sut.recoverRate()
        let currenttimestamp = sut.recoverTimestamp()

        let rate = 23.5
        let timestamp = 1642788124

        sut.saveRate(rate)
        sut.saveTime(timestamp)
        XCTAssertEqual(sut.recoverRate(), 23.5)
        XCTAssertEqual(sut.recoverTimestamp(), 1642788124)

        sut.saveRate(currentRate)
        sut.saveTime(currenttimestamp)
        XCTAssertEqual(sut.recoverRate(), currentRate)
        XCTAssertEqual(sut.recoverTimestamp(), currenttimestamp)
    }
}

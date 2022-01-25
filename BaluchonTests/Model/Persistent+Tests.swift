//
//  Persistent+Tests.swift
//  BaluchonTests
//
//  Created by fred on 21/01/2022.
//

import XCTest
@testable import Baluchon

class Persistent_Tests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_recover_and_save_persistent_data() {
        let currentRate = Persistent.recoverRate()
        let currenttimestamp = Persistent.recoverTimestamp()

        let rate = 23.5
        let timestamp = 1642788124

        Persistent.saveRate(rate)
        Persistent.saveTime(timestamp)
        XCTAssertEqual(Persistent.recoverRate(), 23.5)
        XCTAssertEqual(Persistent.recoverTimestamp(), 1642788124)

        Persistent.saveRate(currentRate)
        Persistent.saveTime(currenttimestamp)
        XCTAssertEqual(Persistent.recoverRate(), currentRate)
        XCTAssertEqual(Persistent.recoverTimestamp(), currenttimestamp)
    }
}

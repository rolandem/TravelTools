//
//  TestCase.swift
//  BaluchonTests
//
//  Created by fred on 07/01/2022.
//

import XCTest
@testable import Baluchon

class TestCase: XCTestCase {

    static func stubNextResponse(from json: String) -> URL? {
        let bundle = Bundle(for: FakeResponseData.self)
        return bundle.url(forResource: json, withExtension: "json")
    }
    
}

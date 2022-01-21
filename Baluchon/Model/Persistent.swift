//
//  Defaults.swift
//  Baluchon
//
//  Created by fred on 21/01/2022.
//

import Foundation

class Persistent {

    static var shared = Persistent()
    private init() {}

    let _rate = "rateUsd"
    let _timestamp = "timestamp"
    private let userDefault = UserDefaults.standard

    func saveRate(_ rate: Double) {
        userDefault.set(rate, forKey: _rate)
    }

    func recoverRate() -> Double {
        return userDefault.double(forKey: _rate)
    }

    func saveTime(_ timestamp: Int) {
        userDefault.set(timestamp, forKey: _timestamp)
    }

    func recoverTimestamp() -> Int {
        return userDefault.integer(forKey: _timestamp)
    }
}

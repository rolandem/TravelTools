//
//  Defaults.swift
//  Baluchon
//
//  Created by fred on 21/01/2022.
//

import Foundation

class Persistent {

    /// methods for saving and retrieving data in UserDefaults

    static var shared = Persistent()
    private init() {}

    var _rate = "rateUsd"
    var _timestamp = "timestamp"
    private static var userDefault = UserDefaults.standard

    static func saveRate(_ rate: Double) {
        userDefault.set(rate, forKey: Persistent.shared._rate)
    }

    static func recoverRate() -> Double {
        return userDefault.double(forKey: Persistent.shared._rate)
    }

    static func saveTime(_ timestamp: Int) {
        userDefault.set(timestamp, forKey: Persistent.shared._timestamp)
    }

    static func recoverTimestamp() -> Int {
        return userDefault.integer(forKey: Persistent.shared._timestamp)
    }
}

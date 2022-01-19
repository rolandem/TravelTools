//
//  Double+.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

extension Double {
    /// use to display temperature
    func withoutDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = " "
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
    /// use to have two decimal in converted result
    func withDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
}

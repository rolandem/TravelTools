//
//  String+.swift
//  Baluchon
//
//  Created by fred on 14/01/2022.
//

import Foundation

extension String {

    func replaceDecimal() -> String {
        return self.replacingOccurrences(of: ",", with: ".")
    }
}

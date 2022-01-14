//
//  String+.swift
//  Baluchon
//
//  Created by fred on 14/01/2022.
//

import Foundation

extension String {

    func replaceComma() -> String {
        return self.replacingOccurrences(of: ",", with: ".")
    }

    func replaceDot() -> String {
        return self.replacingOccurrences(of: ".", with: ",")
    }
}

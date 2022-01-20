//
//  OptionalString+.swift
//  Baluchon
//
//  Created by fred on 20/01/2022.
//

import Foundation

extension Optional where Wrapped == String {

    /// to replace ?? ""
    var orEmpty: String {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return wrapped
        }
    }
}

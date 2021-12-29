//
//  ConvertAPI.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

struct ConvertAPI {
    
    private let apiKey = ""

    static var convertUrl: URL? {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "data.fixer.io"
        component.path = "/api/latest?access_key=apiKey"
        return component.url
    }
}

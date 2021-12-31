//
//  ConvertAPI.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

struct ConvertAPI {
    
    private static let apiKey = "188a2d00478247ae91af935185a74cdf"

    static var convertUrl: URL? {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "data.fixer.io"
        component.path = "/api/latest"
        component.queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        return component.url
    }
}

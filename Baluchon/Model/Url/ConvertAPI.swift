//
//  ConvertAPI.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

struct ConvertAPI {

    var apiKey = Bundle.main.infoDictionary?["CONVERT_API_KEY"] as? String ?? ""

    var convertUrl: URL? {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "data.fixer.io"
        component.path = "/api/latest"
        component.queryItems = [URLQueryItem(name: "access_key", value: "\(apiKey)")]
        return component.url
    }
}

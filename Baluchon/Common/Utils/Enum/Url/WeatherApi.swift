//
//  UrlApi.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

private var apiKey: String = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String ?? ""
private let locale = "New York"
private let lang = "fr"
private let unit = "metric"

enum WeatherAPI {
    case getLocale
    case getDestination(destination: String)
 
    var url: URL? {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "api.openweathermap.org"
        component.path = "/data/2.5/weather"
        component.queryItems = cityQuery()
        return component.url
    }
    
    private func cityQuery()-> [URLQueryItem]? {
        switch self {
        case .getLocale:
            return [
                URLQueryItem(name: "q", value: locale),
                URLQueryItem(name: "units", value: unit),
                URLQueryItem(name: "lang", value: lang),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        case .getDestination(let destination):
            return [
                URLQueryItem(name: "q", value: destination),
                URLQueryItem(name: "units", value: unit),
                URLQueryItem(name: "lang", value: lang),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        }
    }
}

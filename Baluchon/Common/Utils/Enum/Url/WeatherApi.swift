//
//  UrlApi.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

struct WeatherAPI {

    static var shared = WeatherAPI()
        private init() {}
    
    var apiKey: String = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String ?? ""
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    let lang = "fr"
    let unit = "metric"

    func getUrl(location: String) -> URL? {

        var component = URLComponents()
        component.scheme = "http"
        component.host = "api.openweathermap.org"
        component.path = "/data/2.5/weather"
        component.queryItems = [
            URLQueryItem(name: "q", value: location),
            URLQueryItem(name: "units", value: unit),
            URLQueryItem(name: "lang", value: lang),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        return component.url
    }
}

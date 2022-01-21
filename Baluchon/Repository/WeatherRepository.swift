//
//  WeatherRepository.swift
//  Baluchon
//
//  Created by fred on 21/01/2022.
//

import Foundation

typealias WeatherOrError = (_ weather: (WeatherData)?, _ error: Error?) -> Void

class WeatherRepository {

    static var shared = WeatherRepository()
    private init() {}

    var apiKey: String = (Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String).orEmpty
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    let lang = "fr"
    let unit = "metric"
 
    func getWeather(
        location: String,
        completion: @escaping WeatherOrError
    ) {
        let weatherUrl = getUrl(location: location)
        guard let url = weatherUrl else {
            completion(nil, nil)
            return }
        APIService.shared.getData(
            request: url,
            dataType: WeatherData.self
        ) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let weatherData):
                completion(weatherData, nil)
            }
        }
    }
}

extension WeatherRepository {

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

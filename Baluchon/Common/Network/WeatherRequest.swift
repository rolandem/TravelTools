//
//  WeatherRequest.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

class WeatherRequest {

    static var shared = WeatherRequest()
    private init(){}

    private var task: URLSessionDataTask?

    private var localWeatherSession = URLSession(configuration: .default)
    private var destinationWeatherSession = URLSession(configuration: .default)
    init(localWeatherSession: URLSession, destinationWeatherSession: URLSession) {
        self.localWeatherSession = localWeatherSession
        self.destinationWeatherSession = destinationWeatherSession
    }
    
    private let localUrl = WeatherAPI.getLocale.url
    
    func getLocalWeather(callback: @escaping(Result<WeatherData, WeatherError>) -> Void) {

        guard let weatherLocalUrl = localUrl else {
            print(WeatherError.wrongUrl)
            return }
        
        task?.cancel()
        task = localWeatherSession.dataTask(with: weatherLocalUrl) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.error(error: error)))
                    return
                }
                
                guard let data = data, error == nil else {
                    callback(.failure(.missingData))
                    return
                }
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    let meteo = weatherData
                    print("météo", meteo)
                    callback(.success(weatherData))
                } catch {
                    callback(.failure(.cannotProcessData))
                }
            }
        }
        task?.resume()
    }
    
    func getDestinationWeather(destination: String, callback: @escaping(Result<WeatherData, WeatherError>) -> Void) {

        let destinationUrl = WeatherAPI.getDestination(destination: destination).url
        guard let weatherDestinationUrl = destinationUrl else {
            print(WeatherError.wrongUrl)
            return }

        task?.cancel()
        task = destinationWeatherSession.dataTask(with: weatherDestinationUrl) { (data, response, error) in
            DispatchQueue.main.async {

                if error != nil {
                    callback(.failure(.error(error: error)))
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.missingData))
                    return
                }
                
                guard let data = data else {
                    callback(.failure(.missingData))
                    return
                }
                
                do {
                    let weatherDestination = try JSONDecoder().decode(WeatherData.self, from: data)
                    callback(.success(weatherDestination))
                } catch {
                    callback(.failure(.cannotProcessData))
                    // msg alert non trouvé - ajout tiret dans nom composé
                }
            }
        }
        task?.resume()
    }
}

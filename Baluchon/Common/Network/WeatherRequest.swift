//
//  WeatherRequest.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

class WeatherRequest {
    
    private static let localUrl = WeatherAPI.getLocale.url
    
    static func getLocalWeather(callback: @escaping(Result<WeatherData, WeatherError>) -> Void) {
        
        let session = URLSession(configuration: .default)
        
        guard let weatherLocalUrl = localUrl else {
            print(WeatherError.wrongUrl)
            return }
        
        print("localUrl =", localUrl as Any)
        
        session.dataTask(with: weatherLocalUrl) { (data, response, error) in
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
        }.resume()
    }
    
    static func getDestinationWeather(destination: String, callback: @escaping(Result<WeatherData, WeatherError>) -> Void) {
        
        let session = URLSession(configuration: .ephemeral)
        
        let destinationUrl = WeatherAPI.getDestination(destination: destination).url
        guard let weatherDestinationUrl = destinationUrl else {
            print(WeatherError.wrongUrl)
            return }

        session.dataTask(with: weatherDestinationUrl) { (data, response, error) in
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
        }.resume()
    }
}

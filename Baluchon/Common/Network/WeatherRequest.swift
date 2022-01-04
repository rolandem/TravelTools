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

    private var localSession = URLSession(configuration: .default)
    private var destinationSession = URLSession(configuration: .default)
    init(localSession: URLSession, destinationSession: URLSession) {
        self.localSession = localSession
        self.destinationSession = destinationSession
    }

    let task = TaskService()
    
    private let localUrl = WeatherAPI.getLocale.url

    // MARK: - Local Weather

    func getLocalWeather(callback: @escaping(Result<WeatherData, TaskService.FetchError>) -> Void) {

        guard let weatherLocalUrl = localUrl else {
            print(TaskService.FetchError.wrongUrl)
            return }
        
        task.taskData(urlSession: localSession,
                      request: weatherLocalUrl,
                      requestDataType: WeatherData.self,
                      completionHandler: callback.self)
    }

    // MARK: - destination Weather

    func getDestinationWeather(destination: String,
                               callback: @escaping(Result<WeatherData, TaskService.FetchError>) -> Void) {

        let destinationUrl = WeatherAPI.getDestination(destination: destination).url
        guard let weatherDestinationUrl = destinationUrl else {
            print(TaskService.FetchError.wrongUrl)
            return }

        task.taskData(urlSession: destinationSession,
                      request: weatherDestinationUrl,
                      requestDataType: WeatherData.self,
                      completionHandler: callback.self)
    }
}

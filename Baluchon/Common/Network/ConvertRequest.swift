//
//  ConvertRequest.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

class ConvertRequest {

    // limited to one instance : Singleton Pattern
    static var shared = ConvertRequest()
    // makes the default initializer inaccessible outside the class
    private init(){}

    private var rateSession = URLSession(configuration: .default)
    init(rateSession: URLSession) {
        self.rateSession = rateSession
    }

    private let rateUrl = ConvertAPI.convertUrl

    let task = TaskService()

//    typealias result<D: Decodable> = (Result<D, TaskService.FetchError>)
//
//    func getRate<D: Decodable>(requestDataType: D.Type, callback: @escaping(result<D>) -> Void) {
        
    func getRate(callback: @escaping(Result<ExchangeRate, TaskService.FetchError>) -> Void) {
    
        guard let rateUrl = rateUrl else {
            print(TaskService.FetchError.wrongUrl)
            return }
       print("rate url", rateUrl)
        task.taskData(urlSession: rateSession,
                      request: rateUrl,
                      requestDataType: ExchangeRate.self,
                      completionHandler: callback.self)
    }
    
}

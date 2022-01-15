//
//  WeatherData.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

struct WeatherData: Decodable {
    
    enum MainKeys: String, CodingKey {
        case skyCondition = "weather"
        case temperatureData = "main"
        case country = "sys"
        case city = "name"
        
        enum SkyConditionKeys: String, CodingKey {
            case description
            case icon
        }
        
        enum TemperaturesKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
            case temperatureMini = "temp_min"
            case temperatureMaxi = "temp_max"
        }
        
        enum CountryKeys: String, CodingKey {
            case country
        }
    }
    
    let description: String
    let icon: String
    let temperature: Double
    let feelsLike: Double
    let temperatureMini: Double
    let temperatureMaxi: Double
    let country: String
    let city: String
    
    init(from decoder: Decoder) throws {
        // main container
        let container = try decoder.container(keyedBy: MainKeys.self)

        // container array with description and icon
        var skyConditionContainer = try container.nestedUnkeyedContainer(forKey: .skyCondition)
        let firstSkyContainer = try skyConditionContainer.nestedContainer(keyedBy: MainKeys.SkyConditionKeys.self)
        self.description = try firstSkyContainer.decode(String.self, forKey: .description)
        self.icon = try firstSkyContainer.decode(String.self, forKey: .icon)
        
        // container with temperature and feelslike
        let temperatureContainer = try container.nestedContainer(keyedBy: MainKeys.TemperaturesKeys.self, forKey: .temperatureData)
        self.temperature = try temperatureContainer.decode(Double.self, forKey: .temperature)
        self.feelsLike = try temperatureContainer.decode(Double.self, forKey: .feelsLike)
        self.temperatureMini = try temperatureContainer.decode(Double.self, forKey: .temperatureMini)
        self.temperatureMaxi = try temperatureContainer.decode(Double.self, forKey: .temperatureMaxi)
        
        // container with country
        let countryContainer = try container.nestedContainer(keyedBy: MainKeys.CountryKeys.self, forKey: .country)
        self.country = try countryContainer.decode(String.self, forKey: .country)
        
        //name in main container
        self.city = try container.decode(String.self, forKey: .city)
        
    }
}

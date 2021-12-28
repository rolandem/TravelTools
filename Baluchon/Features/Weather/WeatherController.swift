//
//  WeatherController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class WeatherController: UIViewController {
    
    @IBOutlet weak var localWeather: WeatherView!
    @IBOutlet weak var research: UITextField!
    @IBOutlet weak var destinationWeather: WeatherView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalWeather()
    }
    
    private func getLocalWeather() {
        WeatherRequest.getLocalWeather { [self] result in
            switch result {
            case .failure(let error) : print(error)
            case .success(let meteoData) :
                localWeather.cityName.text = meteoData.city
                localWeather.countryName.text = meteoData.country.country
                localWeather.skyConditions.text = "actuellement " + meteoData.skyConditions[0].description
                localWeather.temperature.text = String(meteoData.temperature.temperature) + " °C"
                localWeather.weatherIcon.image = UIImage(named: meteoData.skyConditions[0].icon)
            }
        }
    }
    
    @IBAction func StartResearch(_ sender: UIButton) {
        guard let destination = research.text else { return }
        
        WeatherRequest.getDestinationWeather(destination: destination) { [self] result in
            switch result {
            case .failure(let error) : print(error)
            case .success(let meteoData) :
                destinationWeather.cityName.text = meteoData.city
                destinationWeather.countryName.text = meteoData.country.country
                destinationWeather.skyConditions.text = "actuellement " + meteoData.skyConditions[0].description
                destinationWeather.temperature.text = String(meteoData.temperature.temperature) + " °C"
                destinationWeather.weatherIcon.image = UIImage(named: meteoData.skyConditions[0].icon)
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

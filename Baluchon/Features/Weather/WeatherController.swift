//
//  WeatherController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit
import AVKit

class WeatherController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var localWeather: WeatherView!
    @IBOutlet weak var research: UITextField!
    @IBOutlet weak var destinationWeather: WeatherView!

    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalWeather()
        self.title = "Météo"
    }

    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }

    // MARK: - Get Weather

    private func getLocalWeather() {

        let weatherUrl = WeatherAPI.getLocale
        guard let url = weatherUrl.url else {
            AlertView().presentAlert(message: "L'adresse de la ressource semble erronée")
            return }

        APIService.shared.getData(request: url, dataType: Weather.self) { [self] result in
            switch result {
            case .failure(let error) :
                AlertView().presentAlert(message: error.localizedDescription)
            case .success(let localData) :
                setupWeatherView(with: localData, from: localWeather)
            }
        }
    }

    @IBAction func getDestinationWeather(_ sender: UIButton) {
        guard let destination = research.text else { return }

        let weatherUrl = WeatherAPI.getWeather(destination: destination)
        guard let url = weatherUrl.url else {
            AlertView().presentAlert(message: "L'adresse de la ressource semble erronée")
            return }

        APIService.shared.getData(request: url, dataType: Weather.self) { [self] result in
            switch result {
            case .failure(let error) :
                AlertView().presentAlert(message: error.localizedDescription)
            case .success(let destinationData) :
                setupWeatherView(with: destinationData, from: destinationWeather)
            }
        }
        research.resignFirstResponder()
    }
 
    // MARK: - Keyboard

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        research.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        research.resignFirstResponder()
        return true
    }

    // MARK: - Player Video

    private func setupVideo() {

        // get the path to the video resource
        let bundlePath = Bundle.main.path(forResource: "SkyBackground", ofType: "mp4")
        guard bundlePath != nil else { return }

        // create a url from the path
        let url = URL(fileURLWithPath: bundlePath!)

        let item = AVPlayerItem(url: url)
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)

        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width * 1.5, y: 0, width: self.view.frame.size.width * 4, height: self.view.frame.size.height)

        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.5)
    }
}
extension WeatherController {

    func setupWeatherView(with meteoData: (Weather), from location: WeatherView) {
        location.cityName.text = meteoData.city
        location.countryName.text = meteoData.country
        location.skyConditions.text = "actuellement " + meteoData.description
        let temperature = meteoData.temperature.withoutDecimal()
        let feelsLike = meteoData.feelsLike.withoutDecimal()
        let tempMini = meteoData.temperatureMini.withoutDecimal()
        let tempMaxi = meteoData.temperatureMaxi.withoutDecimal()
        location.temperature.text = "\(temperature) °C"
        location.delta.text = "Max. \(tempMaxi)°  Min. \(tempMini)°"
        location.feelsLike.text = "ressentie \(feelsLike)°"
        location.weatherIcon.image = UIImage(named: meteoData.icon)
    }
}

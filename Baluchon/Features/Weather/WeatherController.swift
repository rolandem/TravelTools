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
        destinationWeather.isHidden = true
        setLocalWeather()
        self.title = "Météo"
    }

    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }

    private func setLocalWeather() {
        DispatchQueue.main.async {
            WeatherRequest.shared.getLocalWeather { [self] result in
                switch result {
                case .failure(let error) : print(error)
                case .success(let meteoData) :
                    localWeather.cityName.text = meteoData.city
                    localWeather.countryName.text = meteoData.country
                    localWeather.skyConditions.text = "actuellement " + meteoData.description
                    let temperature = meteoData.temperature.withoutDecimal()
                    localWeather.temperature.text = "\(temperature) °C"
                    localWeather.weatherIcon.image = UIImage(named: meteoData.icon)
                }
            }
        }
    }

    @IBAction func startResearch(_ sender: UIButton) {
        guard let destination = research.text else { return }

        DispatchQueue.main.async { [self] in
            WeatherRequest.shared.getDestinationWeather(destination: destination) { [self] result in
            switch result {
            case .failure(let error) : print(error)
            case .success(let meteoData) :
                destinationWeather.cityName.text = meteoData.city
                destinationWeather.countryName.text = meteoData.country
                destinationWeather.skyConditions.text = "actuellement " + meteoData.description
                let temperature = meteoData.temperature.withoutDecimal()
                destinationWeather.temperature.text = "\(temperature) °C"
                destinationWeather.weatherIcon.image = UIImage(named: meteoData.icon)
            }
        }
            destinationWeather.isHidden = false
        }
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

        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height - 80)

        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.5)
    }
}

// Vidéo de MART PRODUCTION provenant de Pexels

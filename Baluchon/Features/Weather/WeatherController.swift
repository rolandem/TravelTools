//
//  WeatherController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit
import AVKit

class WeatherController: UIViewController {
    
    @IBOutlet weak var localWeather: WeatherView!
    @IBOutlet weak var research: UITextField!
    @IBOutlet weak var destinationWeather: WeatherView!
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        destinationWeather.isHidden = true
        getLocalWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
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
        destinationWeather.isHidden = false
    }
 
// MARK: - Player Video
    
    private func setupVideo() {
        
        // obtenir le chemin d'accès à la resource vidéo
        let bundlePath = Bundle.main.path(forResource: "SkyBackground", ofType: "mp4")
        guard bundlePath != nil else { return }
        
        //créer une url à partir du chemin
        let url = URL(fileURLWithPath: bundlePath!)
        
        
        let item = AVPlayerItem(url: url)
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.3)
    }


}

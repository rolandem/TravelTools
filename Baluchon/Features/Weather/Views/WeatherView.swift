//
//  WeatherView.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var skyConditions: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var delta: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
}

extension WeatherView {

    private func loadXib() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

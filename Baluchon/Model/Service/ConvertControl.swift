//
//  ConvertService.swift
//  Baluchon
//
//  Created by fred on 15/01/2022.
//

import Foundation
import UIKit

class ConvertControl {

    var defaults = UserDefaults.standard
    lazy var rate = defaults.double(forKey: "usdrate")
    lazy var timestamp = defaults.integer(forKey: "timestamp")

    /// check if is the same day
    func launchQueryIfNeeded() {
        guard let lastStatementDay = Int(lastDay()),
              let currentDay = Int(currentDay()) else { return }

        let delta = abs(currentDay) - abs(lastStatementDay)
        if delta >= 1 {
            getRate()
        }
    }

    private func getUrl() -> URL {
        let convertUrl = ConvertAPI().convertUrl
        guard let url = convertUrl else {
            AlertView().presentAlert(message: "L'adresse de la ressource semble erronée")
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    private func getRate() {

        APIService.shared.getData(request: getUrl(), dataType: RateData.self) { result in
            switch result {
            case .failure(let error) :
                AlertView().presentAlert(message:error.localizedDescription)
            case.success(let rateData) :
                let timestamp = rateData.timestamp
                let usdRate = rateData.USD.withDecimal()
                guard let rate = Double(usdRate) else { return }
                self.defaults.set(rate, forKey: "usdrate")
                self.defaults.set(timestamp, forKey: "timestamp")
            }
        }
    }

    // MARK: - Convenience Methods

    func getConvertedAmount(with amountText: String?, originIcon: String) -> String {
        
        guard var _amountText = amountText else {
            return " "
        }
        /// replace comma by dot to convert String to Double
        _amountText = _amountText.replaceComma()
        
        guard let amount = Double(_amountText) else {
            AlertView().presentAlert(message: "Oups, le montant est incorrect")
            return " "
        }
        
        let isDollar = originIcon == "$"
        let _rate = isDollar ? (1/rate) : rate
        let result = amount * _rate
        return String(result.withDecimal()).replaceDot()
    }

    // MARK: - Formatted Dates

    func lastStatementDate() -> String {
        return formattedDate(timestamp, format: "dd/MM/yyyy")
    }
    
    private func lastDay() -> String {
        let timestamp = defaults.integer(forKey: "timestamp")
        return formattedDate(timestamp, format: "dd")
    }

    private func currentDay() -> String {
        let currentTime = TimeInterval(Date().timeIntervalSince1970)
        return formattedDate(Int(currentTime), format: "dd")
    }

    private func formattedDate(_ timestamp: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 3600)
        return formatter.string(from: date)
    }
}

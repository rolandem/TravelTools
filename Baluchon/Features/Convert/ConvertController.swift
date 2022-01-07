//
//  ConvertController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class ConvertController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var originIcon: UILabel!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var convertedIcon: UILabel!
    @IBOutlet weak var infoText: UILabel!

    private var originDevice = "€"
    private var convertedDevice = "$"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convertisseur"
        launchQuery()
    }

    // MARKS: - Common Methods

    private func launchQuery() {
        guard let lastStatementDay = Int(lastDay()) else { return }
        guard let currentDay = Int(currentDay()) else { return }

        let delta = abs(currentDay) - abs(lastStatementDay)
        if delta >= 1 {
            getUsdRate()
        }
        updateInfoRate()
    }
    
    private func getUsdRate() {
        ConvertRequest.shared.getRate { (result) in
            switch result {
            case .failure(let response) :
                let error = response.self
                print("error", error)
                
            case.success(let rateData) :
                let timestamp = rateData.timestamp
                let usdRate = rateData.USD.withDecimal()
                guard let rate = Double(usdRate) else { return }
                self.defaults.set(rate, forKey: "usdrate")
                self.defaults.set(timestamp, forKey: "timestamp")
            }
        }
    }

    private func updateInfoRate() {
        let rate = defaults.double(forKey: "usdrate")
        let lastStatementDate = lastStatementDate()

        infoText.text = "Le \(lastStatementDate), 1 € (Euro) = \(rate) $ ((Dollar)"
    }

    // MARKS: - Formatted Dates

    private func lastStatementDate() -> String {
        let timestamp = defaults.integer(forKey: "timestamp")
        return formattedDate(timestamp, format: "dd/MM/yyyy")
    }

    private func lastDay() -> String {
        let timestamp = defaults.integer(forKey: "timestamp")
        return formattedDate(timestamp, format: "dd")
    }

    private func currentDate() -> String{
        let currentTime = TimeInterval(Date().timeIntervalSince1970)
        return formattedDate(Int(currentTime), format: "dd/MM/yyyy")
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

    // MARK: - IBActions

    @IBAction func SwitchButton(_ sender: UIButton) {
        swap(&originDevice, &convertedDevice)
        originIcon.text = originDevice
        convertedIcon.text = convertedDevice
        amountField.text = ""
        resultAmount.text = "0.00"
    }

    @IBAction func ConvertButton(_ sender: UIButton) {
        guard let amountText = amountField.text else { return }
        guard let amount = Double(amountText) else { return }
        let rate = defaults.double(forKey: "usdrate")
        if originIcon.text == "€" {
            let result = amount * rate
            resultAmount.text = String(result.withDecimal())
        } else {
            let result = amount * (1/rate)
            resultAmount.text = String(result.withDecimal())
        }
    }

    // MARK: - Keyboard

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountField.resignFirstResponder()
        return true
    }
    
}

// Photo de Karolina Grabowska provenant de Pexels

//
//  ConvertController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class ConvertController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var originCode: UILabel!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var convertedCode: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var rate: Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsdRate()
    }

    private func getUsdRate() {
        ConvertRequest.getRate { (result) in
            switch result {
            case .failure(let error) : print(error)
            case.success(let rateData) :
                let timestamp = rateData.timestamp
                let usdRate = rateData.rates.USD.withDecimal()
                guard let rate = Double(usdRate) else { return }
                self.rate = rate
                let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                self.infoText.text = "1 € (Euro) = \(usdRate) $ (Dollar)"
                print("date", date)
            }
        }
    }

    // MARK: - IBActions

    @IBAction func SwitchButton(_ sender: UIButton) {
        if originCode.text == "€" {
            amountField.text = ""
            resultAmount.text = "0.00"
            originCode.text = "$"
            convertedCode.text = "€"
        } else {
            amountField.text = ""
            resultAmount.text = "0.00"
            originCode.text = "€"
            convertedCode.text = "$"
        }
    }

    @IBAction func ConvertButton(_ sender: UIButton) {
        guard let amountText = amountField.text else { return }
        guard let amount = Double(amountText) else { return }
        
        if originCode.text == "€" {
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


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
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var rate: Double = 1.13
    
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
                let usdRate = rateData.rate.USD.withDecimal()
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
        if originIcon.text == "€" {
            amountField.text = ""
            resultAmount.text = "0.00"
            originIcon.text = "$"
            convertedIcon.text = "€"
        } else {
            amountField.text = ""
            resultAmount.text = "0.00"
            originIcon.text = "€"
            convertedIcon.text = "$"
        }
    }

    @IBAction func ConvertButton(_ sender: UIButton) {
        guard let amountText = amountField.text else { return }
        guard let amount = Double(amountText) else { return }
        
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


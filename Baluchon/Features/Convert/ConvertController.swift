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
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var convertToButton: UIButton!

    var originCurrency = "€"
    var convertedCurrency = "$"

    let control = ConvertControl()
    lazy var rate = control.defaults.double(forKey: "usdrate")
    lazy var lastStatementDate = control.lastStatementDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convertisseur"
        control.launchQueryIfNeeded()
        updateInfoRate()
    }

    private func updateInfoRate() {
        infoText.text = "Le \(lastStatementDate):  1 € (Euro) = \(rate) $ ((Dollar)"
    }

    // MARK: - IBActions

    @IBAction func switchIconCurrency(_ sender: UIButton) {
        swap(&originCurrency, &convertedCurrency)
        originIcon.text = originCurrency
        convertedIcon.text = convertedCurrency
        amountField.text = ""
        resultAmount.text = "0.00"
    }

    @IBAction func convertButton(_ sender: UIButton) {
        let amount = control.getConvertedAmount(
            with: amountField.text,
            originIcon: originCurrency
        )
        resultAmount.text = amount
        amountField.resignFirstResponder()
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

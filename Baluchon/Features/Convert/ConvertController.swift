//
//  ConvertController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class ConvertController: UIViewController {
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var eurCode: UILabel!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var dollarCode: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions

    @IBAction func SwitchButton(_ sender: UIButton) {
    }

    @IBAction func ConvertButton(_ sender: UIButton) {
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


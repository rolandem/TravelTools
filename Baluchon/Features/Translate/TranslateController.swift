//
//  TranslateController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class TranslateController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var originalText: UITextView!
    @IBOutlet weak var translatedText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func translateTexte(_ sender: UIButton) {
        guard let inputText = originalText.text else { return }
        
        TranslateRequest.getLTranslation(inputText: inputText, sourceLang: "fr", targetLang: "en") { result in
            switch result {
            case .failure(let error) : print(error)
            case .success(let translation) :
                self.translatedText.text = translation.translationData.translations[0].translatedText
            }
        }
    }
    
    // MARK: - Keyboard

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        originalText.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        originalText.resignFirstResponder()
        return true
    }
   
}

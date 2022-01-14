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
    @IBOutlet weak var originalLanguage: UIButton!
    @IBOutlet weak var translatedLanguage: UIButton!

    private let tableView = UITableView()
    private let darkenView = UIView()
    private var selectedButton = UIButton()
    private var dataSource = languages
    private var sourceLanguage = "fr"
    private var targetLanguage = "en"
    private var titleLeftButton = "Français"
    private var titleRightButton = "Anglais"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Traducteur"
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Get translation

    @IBAction func translateText(_ sender: UIButton) {
        guard let inputText = originalText.text else { return }
  
        let translateUrl = TranslateAPI.shared.getUrl(
            inputText: inputText,
            sourceLang: sourceLanguage,
            targetLang: targetLanguage
        )
        
        guard let url = translateUrl else {
            AlertView().presentAlert(message: "L'adresse de la ressource semble erronée")
            return
        }

        APIService.shared.getData(
            request: url,
            dataType: Translation.self
        ) { result in
            switch result {
            case .failure(let error) :
                AlertView().presentAlert(message: error.localizedDescription)
            case .success(let translation) :
                self.translatedText.text = translation.translatedText
            }
        }
        originalText.resignFirstResponder()
    }

    // MARK: - IBActions

    @IBAction func cancelTextView(_ sender: UIButton) {
        originalText.text = ""
    }

    @IBAction func switchLanguages(_ sender: UIButton) {
        swap(&sourceLanguage, &targetLanguage)
        swap(&titleLeftButton, &titleRightButton)
        swap(&originalText.text, &translatedText.text)
        originalLanguage.setTitle(titleLeftButton, for: .normal)
        translatedLanguage.setTitle(titleRightButton, for: .normal)
    }
    
    // MARK: - Language choice buttons

    @IBAction func originalLanguageSelect(_ sender: UIButton) {
        originalText.resignFirstResponder()
        selectedButton = originalLanguage
        addDarkenView(at: originalLanguage.frame)
    }

    @IBAction func translatedLanguageSelect(_ sender: UIButton) {
        originalText.resignFirstResponder()
        selectedButton = translatedLanguage
        addDarkenView(at: translatedLanguage.frame)
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

// MARK: - UITableViewDataSource

extension TranslateController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font.withSize(15.0)
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TranslateController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row].name, for: .normal)
        translatedText.text = ""
        if selectedButton == originalLanguage {
            titleLeftButton = dataSource[indexPath.row].name
            sourceLanguage = dataSource[indexPath.row].codeISO
        } else {
            titleRightButton = dataSource[indexPath.row].name
            targetLanguage = dataSource[indexPath.row].codeISO
        }
        removeDarkenView()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TranslateController {

    func frameTableView(frame: CGRect, x:CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        tableView.frame = CGRect(
            x: frame.origin.x + x,
            y: frame.origin.y + frame.height + y,
            width: frame.width + width,
            height: height
        )
    }

    func addDarkenView(at frame: CGRect) {
        darkenView.frame = view.frame
        darkenView.backgroundColor = .black.withAlphaComponent(0.9)
        view.addSubview(darkenView)

        let frameWhenTableViewIsHidden = CGRect(
            x: frame.origin.x,
            y: frame.origin.y + frame.height + 5,
            width: frame.width,
            height: 0
        )
        tableView.frame = frameWhenTableViewIsHidden

        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(removeDarkenView)
        )
        tapGesture.delegate = self
        darkenView.addGestureRecognizer(tapGesture)
        darkenView.alpha = 0
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.darkenView.alpha = 0.5
                self.frameTableView(
                    frame: frame, x: 0, y: 5, width: 0,
                    height: CGFloat(self.dataSource.count * 10)
                )
            }, completion: nil
        )
        tableView.reloadData()
    }

    @objc func removeDarkenView() {
        let frames = selectedButton.frame
        UIView.animate(
            withDuration: 0.4, delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.darkenView.alpha = 0
                self.frameTableView(frame: frames, x: 0, y: 5, width: 0, height: 0)
            }, completion: nil
        )
    }
}

extension TranslateController: UIGestureRecognizerDelegate {

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch) -> Bool {
            if touch.view != nil && touch.view!.isDescendant(of: self.tableView) {
            return false
        }
        return true
    }
}

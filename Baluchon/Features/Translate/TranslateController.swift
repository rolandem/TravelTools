//
//  TranslateController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class TranslateController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var originalText: UITextView!
    @IBOutlet weak var translatedText: UILabel!
    @IBOutlet weak var originalLanguage: UIButton!
    @IBOutlet weak var translatedLanguage: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var switchButton:UIButton!

    let tableView = UITableView()
    let darkenView = UIView()
    private var selectedButton = UIButton()
    var dataSource = languages
    var sourceLanguage = "fr"
    var targetLanguage = "en"
    var titleLeftButton = "Français"
    var titleRightButton = "Anglais"

    private let repository = TranslateRepository.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Traducteur"
        cancelButton.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - @IBActions

    @IBAction func translateText(_ sender: UIButton) {
        /// allocation of the result of the repository
        repository.getTranslation(
            for: originalText.text,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage
        ) { [weak self] (translation, error) in
            if let error = error {
                AlertView().presentAlert(message: error.localizedDescription)
                return
            }
            self?.translatedText.text = translation
        }
        /// hides the keyboard
        originalText.resignFirstResponder()
    }

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

    // MARK: - Hides the keyboard

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        originalText.resignFirstResponder()
        cancelButton.isHidden = true
    }

    // MARK: - Cancel button - TextfieldDelegate

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        cancelButton.isHidden = false
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
        cell.textLabel?.font.withSize(0.5)
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
            originalText.text = ""
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

    /// Dark view on the main view when the tableView is displayed

    func frameTableView(frame: CGRect, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        tableView.frame = CGRect(
            x: frame.origin.x + x,
            y: frame.origin.y + frame.height + y,
            width: frame.width + width,
            height: height
        )
    }

    func addDarkenView(at frame: CGRect) {
        /// add darkenView
        darkenView.frame = view.frame
        darkenView.backgroundColor = .black.withAlphaComponent(0.9)
        view.addSubview(darkenView)

        /// definition of the tableview frame in relation to the select button (parameter frame)
        let frameWhenTableViewIsHidden = CGRect(
            x: frame.origin.x,
            y: frame.origin.y + frame.height + 5,
            width: frame.width,
            height: 0
        )

        /// tableview is invisible, zero height
        tableView.frame = frameWhenTableViewIsHidden
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5

        /// creating the gesture to hide the tableview and darkenView
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(removeDarkenView)
        )
        tapGesture.delegate = self
        darkenView.addGestureRecognizer(tapGesture)
        darkenView.alpha = 0
        
        /// Animation deploying the tableview
        view.animation {
            self.darkenView.alpha = 0.5
            self.frameTableView(
                frame: frame, x: 0, y: 5, width: 0,
                height: CGFloat(self.dataSource.count * 10)
            )
        }
        tableView.reloadData()

    }

    @objc func removeDarkenView() {
        let frames = selectedButton.frame
        view.animation {
            self.darkenView.alpha = 0
            self.frameTableView(
                frame: frames, x: 0, y: 5, width: 0, height: 0)
        }
    }
}

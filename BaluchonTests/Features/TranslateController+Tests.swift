//
//  TranslateController+Tests.swift
//  BaluchonTests
//
//  Created by fred on 16/01/2022.
//

import XCTest
@testable import Baluchon

class TranslateController_Tests: XCTestCase {

    var sut: TranslateController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "TranslateController", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "TranslateController") as? TranslateController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_when_switchLanguages_is_pressed_titleButtons_swap() throws {
        // arrange
        guard let button = sut.switchButton else { return }
        _ = sut.sourceLanguage    /// "fr"
        _ = sut.targetLanguage     /// "en"
        _ = sut.titleLeftButton   /// "Anglais"
        _ = sut.titleRightButton /// "Français"

        // act
        sut.switchLanguages(button)

        // assert
        XCTAssertEqual(sut.sourceLanguage, "en")
        XCTAssertEqual(sut.targetLanguage, "fr")
        XCTAssertEqual(sut.titleLeftButton, "Anglais")
        XCTAssertEqual(sut.titleRightButton, "Français")
    }

    func test_given_textView_tapped_when_keyboard_appears_then_cancelButton_is_visible() throws {
        // arrange
        guard let textview = sut.originalText else { return }

        // act
        _ = sut.textViewShouldBeginEditing(textview)

        // assert
        XCTAssertFalse(sut.cancelButton.isHidden)
    }

    func test_given_keyboard_when_dismiss_then_cancelButton_is_hidden() throws {
        // arrange
        guard let textview = sut.originalText else { return }

        // act
        textview.resignFirstResponder()

        // assert
        XCTAssertTrue(sut.cancelButton.isHidden)
    }

    func test_given_languageButtons_when_selected_then_darkview_appears() throws {
        // arrange
        let darkView = sut.darkenView
        guard let view = sut.view else { return }
        // act
        sut.addDarkenView(at: view.frame)
        // assert
        XCTAssertEqual(darkView.alpha, 0.5)
    }

    func test_given_darkview_when_tapView_then_disappear() throws {
        // arrange
        let darkview = sut.darkenView
        // act
        sut.removeDarkenView()
        //assert
        XCTAssertEqual(darkview.alpha, 0)
    }

    func test_given_language_when_isSelected_then_cellTitle_matches() throws {
        // arrange
        let languages = sut.dataSource
        let table = sut.tableView
        let cell = sut.tableView(table, cellForRowAt: IndexPath(row: 2, section: 0))
        // act
        sut.tableView(table, didSelectRowAt: IndexPath(row: 2, section: 0))
        // assert
        XCTAssertEqual(cell.textLabel?.text, languages[2].name)
        XCTAssertEqual(sut.titleRightButton, languages[2].name)
    }
}

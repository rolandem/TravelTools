//
//  TabBarController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class AlertView: UIAlertController {

    private var alertWindow: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.alertWindow?.isHidden = true
        alertWindow = nil
    }

    func show() {
        self.showAnimated(animated: true)
    }

    func showAnimated(animated _: Bool) {

            let blankViewController = UIViewController()
            blankViewController.view.backgroundColor = UIColor.clear

            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = blankViewController
            window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindow.Level.alert + 1
            window.makeKeyAndVisible()
            self.alertWindow = window

            blankViewController.present(self, animated: true, completion: nil)
        }

    func presentAlert(message: String?) {

            let alertController = AlertView(title: "Oups!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            alertController.show()
        }
    }

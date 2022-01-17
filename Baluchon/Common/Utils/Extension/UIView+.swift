//
//  UIView+.swift
//  Baluchon
//
//  Created by fred on 15/01/2022.
//

import Foundation
import UIKit

extension UIView {
    func animation(_ animation: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: animation,
            completion: nil
        )
    }
}

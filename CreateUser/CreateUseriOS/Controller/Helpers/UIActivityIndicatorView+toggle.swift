//
//  UIActivityIndicatorView+toggle.swift
//  CreateUseriOS
//
//  Created by Rasik on 30/03/22.
//

import UIKit

extension UIActivityIndicatorView {
    func toggle(shouldHide: Bool) {
        if shouldHide {
            isHidden = false
            startAnimating()
        } else {
            stopAnimating()
            isHidden = true
        }
    }
}

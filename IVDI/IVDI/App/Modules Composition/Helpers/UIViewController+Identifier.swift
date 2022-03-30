//
//  UIViewController+Identifier.swift
//  IVDI
//
//  Created by Rasik on 30/03/22.
//

import UIKit

extension UIStoryboard {
    func instantiate<T: UIViewController>() -> T {
        let identifier = String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}

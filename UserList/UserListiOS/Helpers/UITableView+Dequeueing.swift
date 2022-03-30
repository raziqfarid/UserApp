//
//  UITableView+Dequeueing.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import UIKit

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>() -> T {
		let identifier = String(describing: T.self)
		return dequeueReusableCell(withIdentifier: identifier) as! T
	}
}

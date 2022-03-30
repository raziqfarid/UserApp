//
//  UIRefreshControl+Helpers.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import UIKit

extension UIRefreshControl {
	func update(isRefreshing: Bool) {
		isRefreshing ? beginRefreshing() : endRefreshing()
	}
}

//
//  HTTPURLResponse.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

extension HTTPURLResponse {
	private static var OK_201: Int { return 201 }

	var isOK_201: Bool {
		return statusCode == HTTPURLResponse.OK_201
	}
}

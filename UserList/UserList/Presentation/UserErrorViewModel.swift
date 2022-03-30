//
//  UserErrorViewModel.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

public struct UserErrorViewModel {
	public let message: String?
	
	static var noError: UserErrorViewModel {
		return UserErrorViewModel(message: nil)
	}
	
	static func error(message: String) -> UserErrorViewModel {
		return UserErrorViewModel(message: message)
	}
}

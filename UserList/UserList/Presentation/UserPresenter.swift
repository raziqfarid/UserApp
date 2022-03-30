//
//  UserPresenter.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public protocol UserView {
	func display(_ viewModel: UserListViewModel)
}

public protocol UserLoadingView {
	func display(_ viewModel: UserLoadingViewModel)
}

public protocol UserErrorView {
	func display(_ viewModel: UserErrorViewModel)
}

public final class UserPresenter {
	private let userView: UserView
	private let loadingView: UserLoadingView
	private let errorView: UserErrorView
	
	private var userLoadError: String {
		return "Couldn't connect to server"
	}
	
	public init(userView: UserView, loadingView: UserLoadingView, errorView: UserErrorView) {
		self.userView = userView
		self.loadingView = loadingView
		self.errorView = errorView
	}
	
	public static var title: String {
		return "User"
	}
	
	public func didStartLoadingUser() {
		errorView.display(.noError)
		loadingView.display(UserLoadingViewModel(isLoading: true))
	}
	
	public func didFinishLoadingUser(with user: [User]) {
        userView.display(UserListViewModel(user: user.map(userViewModelMapper)))
		loadingView.display(UserLoadingViewModel(isLoading: false))
	}
	
	public func didFinishLoadingUser(with error: Error) {
		errorView.display(.error(message: userLoadError))
		loadingView.display(UserLoadingViewModel(isLoading: false))
	}
    
    private func userViewModelMapper(user: User) -> UserViewModel {
        UserViewModel(name: user.name, gender: user.gender.capitalized, email: user.email)
    }
}

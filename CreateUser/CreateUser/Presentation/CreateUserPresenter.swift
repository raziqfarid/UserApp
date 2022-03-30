//
//  CreateUserPresenter.swift
//  IVDI
//
//  Created by Rasik on 25/03/22.
//

import Foundation
public struct CreateUserViewModel {
    public let message: String
}

public protocol CreateUserView {
    func display(_ viewModel: CreateUserViewModel)
}

public struct CreateUserLoadingViewModel {
    public let isLoading: Bool
}

public protocol CreateUserLoadingView {
    func display(_ viewModel: CreateUserLoadingViewModel)
}

public struct CreateUserErrorViewModel {
    public let message: String
    
    static func error(message: String) -> CreateUserErrorViewModel {
        return CreateUserErrorViewModel(message: message)
    }
}

public protocol CreateUserErrorView {
    func display(_ viewModel: CreateUserErrorViewModel)
}


public class CreateUserPresenter {
    private let userView: CreateUserView
    private let loadingView: CreateUserLoadingView
    private let errorView: CreateUserErrorView
    
    public static var title: String {
        return "User"
    }
    
    public init(userView: CreateUserView, loadingView: CreateUserLoadingView, errorView: CreateUserErrorView) {
        self.userView = userView
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public enum ValidationError: Swift.Error {
        case invalidName
        case invalidEmail
        case invalidGender
    }
    
    public func validateData(
        name: String,
        gender: String,
        email: String) throws {
        
        guard !name.isEmpty else {
            throw ValidationError.invalidName
        }
        
        guard !gender.isEmpty else {
            throw ValidationError.invalidGender
        }
        
        guard !email.isEmpty else {
            throw ValidationError.invalidEmail
        }
    }
    
    public func didFinishCreatingUser(with message: String) {
        self.loadingView.display(CreateUserLoadingViewModel(isLoading: false))
        self.userView.display(CreateUserViewModel(message: message))
    }
    
    public func didFinishCreatingUser(with error: Error) {
        self.loadingView.display(CreateUserLoadingViewModel(isLoading: false))
        self.errorView.display(.error(message: error.localizedDescription))
    }
    
    public func didStartCreatingUser() {
        self.loadingView.display(CreateUserLoadingViewModel(isLoading: true))
    }
}

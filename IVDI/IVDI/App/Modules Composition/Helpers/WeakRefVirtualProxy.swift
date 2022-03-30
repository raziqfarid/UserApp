//
//  WeakRefVirtualProxy.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation
import UserList
import CreateUser

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: UserErrorView where T: UserErrorView {
    func display(_ viewModel: UserErrorViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: UserLoadingView where T: UserLoadingView {
    func display(_ viewModel: UserLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: UserView where T: UserView {
    func display(_ viewModel: UserListViewModel) {
        object?.display(viewModel)
    }
}

// MARK:-  Create User
extension WeakRefVirtualProxy: CreateUserView where T: CreateUserView {
    func display(_ viewModel: CreateUserViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: CreateUserLoadingView where T: CreateUserLoadingView {
    func display(_ viewModel: CreateUserLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: CreateUserErrorView where T: CreateUserErrorView {
    func display(_ viewModel: CreateUserErrorViewModel) {
        object?.display(viewModel)
    }
}

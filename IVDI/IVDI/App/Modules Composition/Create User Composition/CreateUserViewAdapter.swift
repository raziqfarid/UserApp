//
//  CreateUserViewAdapter.swift
//  IVDI
//
//  Created by Rasik on 30/03/22.
//

import Foundation
import CreateUser
import CreateUseriOS

final class CreateUserViewAdapter: CreateUserView {
    typealias UserCreated = () -> Void
    
    private weak var controller: CreateUserViewController?
    private var userCreated: (UserCreated)?
    
    init(controller: CreateUserViewController, userCreated: @escaping UserCreated) {
        self.controller = controller
        self.userCreated = userCreated
    }
    
    func display(_ viewModel: CreateUserViewModel) {
        controller?.showAlertMessage(message: viewModel.message, okTapped: userCreated)
    }
}

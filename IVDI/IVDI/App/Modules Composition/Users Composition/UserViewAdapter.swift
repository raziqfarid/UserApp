//
//  UserViewAdapter.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation
import UserList
import UserListiOS

final class UserViewAdapter: UserView {
    private weak var controller: UserListViewController?
    
    init(controller: UserListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: UserListViewModel) {
        controller?.display(viewModel.user.map { model in
            return UserCellController(viewModel: model)
        })
    }
}

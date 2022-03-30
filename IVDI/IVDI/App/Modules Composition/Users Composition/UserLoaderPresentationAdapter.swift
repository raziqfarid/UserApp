//
//  UserLoaderPresentationAdapter.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation
import UserList
import UserListiOS

final class UserLoaderPresentationAdapter: UserListViewControllerDelegate {
    private let userLoader: UserLoader
    var presenter: UserPresenter?
    
    init(userLoader: UserLoader) {
        self.userLoader = userLoader
    }
    
    func didRequestUserRefresh() {
        presenter?.didStartLoadingUser()
        
        userLoader.load { [weak self] result in
            switch result {
            case let .success(user):
                self?.presenter?.didFinishLoadingUser(with: user)
                
            case let .failure(error):
                self?.presenter?.didFinishLoadingUser(with: error)
            }
        }
    }
}

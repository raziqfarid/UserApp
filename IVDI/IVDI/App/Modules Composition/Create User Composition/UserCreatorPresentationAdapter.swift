//
//  UserCreatorPresentationAdapter.swift
//  IVDI
//
//  Created by Rasik on 30/03/22.
//

import Foundation
import CreateUser
import CreateUseriOS

final class UserCreatorPresentationAdapter: CreateUserViewControllerDelegate {
    typealias NewUserData = (CreateUser) -> Void
    
    private let userCreator: UserCreator
    var presenter: CreateUserPresenter?
    
    init(userCreator: UserCreator) {
        self.userCreator = userCreator
    }
    
    func didRequestToCreateUser(name: String, gender: String, email: String) {
        do {
            try presenter?.validateData(name: name, gender: gender, email: email)
            let user = CreateUser(name: name, gender: gender, email: email)
            presenter?.didStartCreatingUser()
            userCreator.create(user: user) { [weak self] (result) in
                switch result {
                case .success:
                    self?.presenter?.didFinishCreatingUser(with: "User created successfully")
                case let .failure(error):
                    self?.presenter?.didFinishCreatingUser(with: error)
                }
            }
        } catch {
            presenter?.didFinishCreatingUser(with: error)
        }
    }
}

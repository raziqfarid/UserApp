//
//  MainQueueDispatchDecorator.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation
import UserList
import CreateUser

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatchDecorator: UserLoader where T == UserLoader {
    func load(completion: @escaping (UserLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: UserCreator where T == UserCreator {
    func create(user: CreateUser, completion: @escaping (UserCreator.Result) -> Void) {
        decoratee.create(user: user) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}


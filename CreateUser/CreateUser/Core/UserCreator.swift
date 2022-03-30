//
//  UserCreator.swift
//  IVDI
//
//  Created by Rasik on 25/03/22.
//

import Foundation

public protocol UserCreator {
    typealias Result = Swift.Result<CreateUser, Error>
    func create(user: CreateUser, completion: @escaping (UserCreator.Result) -> Void)
}

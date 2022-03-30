//
//  UserLoader.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public protocol UserLoader {
    typealias Result = Swift.Result<[User], Error>
    
    func load(completion: @escaping (Result) -> Void)
}

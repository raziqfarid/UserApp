//
//  User.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public struct User {
    public let name: String
    public let gender: String
    public let email: String
    
    public init(name: String, gender: String, email: String) {
        self.name = name
        self.gender = gender
        self.email = email
    }
}

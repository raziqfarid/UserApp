//
//  SendUserItem.swift
//  IVDI
//
//  Created by Rasik on 30/03/22.
//

import Foundation

struct SendUserItem: Encodable {
    let name: String
    let email: String
    let gender: String
    let status: String
    
    init(user: CreateUser) {
        self.name = user.name
        self.email = user.email
        self.gender = user.gender
        self.status = "active"
    }
}

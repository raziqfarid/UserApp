//
//  RemoteCreateUserItem.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

struct RemoteCreateUserItem: Decodable {
	let id: Int
	let name: String
	let email: String
    let gender: String
    let status: String
}

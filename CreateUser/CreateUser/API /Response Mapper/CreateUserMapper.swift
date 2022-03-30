//
//  CreateUserMapper.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

final class CreateUserMapper {
	static func map(_ data: Data, from response: HTTPURLResponse) throws -> RemoteCreateUserItem {
		guard response.isOK_201, let items = try? JSONDecoder().decode(RemoteCreateUserItem.self, from: data) else {
			throw RemoteUserCreator.Error.invalidData
		}

		return items
	}
}

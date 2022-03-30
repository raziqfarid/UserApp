//
//  UserItemsMapper.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

final class UserItemsMapper {
	static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteUserItem] {
		guard response.isOK, let items = try? JSONDecoder().decode([RemoteUserItem].self, from: data) else {
			throw RemoteUserLoader.Error.invalidData
		}

		return items
	}
}

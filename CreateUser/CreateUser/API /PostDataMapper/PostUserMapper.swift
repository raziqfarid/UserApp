//
//  PostUserMapper.swift
//  IVDI
//
//  Created by Rasik on 30/03/22.
//

import Foundation

final class PostUserDataMapper {
    static func map(_ user: SendUserItem) throws -> Data {
        guard let data = try? JSONEncoder().encode(user) else {
            throw RemoteUserCreator.Error.invalidData
        }

        return data
    }
}

//
//  RemoteUserCreator.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public final class RemoteUserCreator: UserCreator {
	private let url: URL
    private let accessToken: String
	private let client: HTTPPostClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public typealias Result = UserCreator.Result
    private typealias PostEncodingResult = Swift.Result<Data, Swift.Error>
	
    public init(url: URL, accessToken: String, client: HTTPPostClient) {
		self.url = url
        self.accessToken = accessToken
		self.client = client
	}
    
    public func create(user: CreateUser, completion: @escaping (UserCreator.Result) -> Void) {
        guard let postData = try? RemoteUserCreator.map(SendUserItem(user: user)).get() else {
            completion(.failure(Error.invalidData))
            return
        }
        
        client.post(from: url, accessToken: accessToken, postData: postData) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success((data, response)):
                completion(RemoteUserCreator.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ user: SendUserItem) -> PostEncodingResult {
        do {
            let data = try PostUserDataMapper.map(user)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
	private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
		do {
			let items = try CreateUserMapper.map(data, from: response)
			return .success(items.model)
		} catch {
            let json = (try? JSONSerialization.jsonObject(with: data) as? [[String: Any]])?.first
            if let field = json?["field"] as? String, let message = json?["message"] as? String {
                return .failure(NSError(domain: field + " " + message, code: 0))
            } else {
                return .failure(error)
            }
		}
	}
}

private extension RemoteCreateUserItem {
    var model: CreateUser {
        CreateUser(name: name, gender: gender, email: email)
    }
}


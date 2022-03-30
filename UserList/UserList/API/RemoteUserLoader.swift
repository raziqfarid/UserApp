//
//  RemoteUserLoader.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public final class RemoteUserLoader: UserLoader {
	private let url: URL
    private let accessToken: String
	private let client: HTTPGetClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public typealias Result = UserLoader.Result
	
    public init(url: URL, accessToken: String, client: HTTPGetClient) {
		self.url = url
        self.accessToken = accessToken
		self.client = client
	}
	
	public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url, accessToken: accessToken) { [weak self] result in
			guard self != nil else { return }
			
			switch result {
			case let .success((data, response)):
				completion(RemoteUserLoader.map(data, from: response))
				
			case .failure:
				completion(.failure(Error.connectivity))
			}
		}
	}
	
	private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
		do {
			let items = try UserItemsMapper.map(data, from: response)
			return .success(items.toModels())
		} catch {
			return .failure(error)
		}
	}
}

private extension Array where Element == RemoteUserItem {
	func toModels() -> [User] {
        return map { User(name: $0.name, gender: $0.gender, email: $0.email) }
	}
}

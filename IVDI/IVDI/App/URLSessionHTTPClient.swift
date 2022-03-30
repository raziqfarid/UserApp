//
//  URLSessionHTTPClient.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation
import UserList
import CreateUser

public final class URLSessionHTTPClient: HTTPGetClient {
	private let session: URLSession
	
	public init(session: URLSession) {
		self.session = session
	}
	
	private struct UnexpectedValuesRepresentation: Error {}
	
	private struct URLSessionTaskWrapper: HTTPGetClientTask, HTTPPostClientTask {
		let wrapped: URLSessionTask
		
		func cancel() {
			wrapped.cancel()
		}
	}
	
    public func get(from url: URL, accessToken: String, completion: @escaping (HTTPGetClient.Result) -> Void) -> HTTPGetClientTask {
        let task = session.dataTask(with: url) { data, response, error in
			completion(Result {
				if let error = error {
					throw error
				} else if let data = data, let response = response as? HTTPURLResponse {
					return (data, response)
				} else {
					throw UnexpectedValuesRepresentation()
				}
			})
		}
		task.resume()
		return URLSessionTaskWrapper(wrapped: task)
	}
}

extension URLSessionHTTPClient: HTTPPostClient {
    public func post(from url: URL, accessToken: String, postData: Data, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> HTTPPostClientTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
        let task = session.dataTask(with: request) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}

//
//  HTTPURLResponse.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public protocol HTTPGetClientTask {
	func cancel()
}

public protocol HTTPGetClient {
	typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
	
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	@discardableResult
	func get(from url: URL, accessToken: String, completion: @escaping (Result) -> Void) -> HTTPGetClientTask
}

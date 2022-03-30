//
//  HTTPPostClient.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import Foundation

public protocol HTTPPostClientTask {
	func cancel()
}

public protocol HTTPPostClient {
	typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
	
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	@discardableResult
    func post(from url: URL, accessToken: String, postData: Data, completion: @escaping (HTTPPostClient.Result) -> Void) -> HTTPPostClientTask
}

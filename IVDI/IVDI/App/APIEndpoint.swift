//
//  APIEndpoint.swift
//  IVDI
//
//  Created by Rasik on 30/03/22.
//

import Foundation

enum APIEndpoint: String {
    case users = "users"
    
    func getURL() -> URL {
        URL(string: "https://gorest.co.in/public/v2/" + rawValue)!
    }
}

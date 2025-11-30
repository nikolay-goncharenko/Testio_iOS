//
//  NetworkConfig.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Alamofire

struct NetworkConfig {
    
    static let baseURL = "https://playground.nordsec.com"
    static let apiVersion = "/v1"
    
    static let defaultHeadears: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    static func authHeadears(withToken token: String?) -> HTTPHeaders {
        var headears = defaultHeadears
        
        if let token {
            headears["Authorization"] = "Bearer \(token)"
        }
        
        return headears
    }
}

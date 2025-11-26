//
//  Endpoints.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation
import Alamofire

enum Endpoints {
    case auth
    case servers
    
    var path: String {
        switch self {
        case .auth: "/tokens"
        case .servers: "/servers"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .auth: .post
        case .servers: .get
        }
    }
    
    var urlRequest: String {
        "\(NetworkConfig.baseURL)\(NetworkConfig.apiVersion)\(path)"
    }
}

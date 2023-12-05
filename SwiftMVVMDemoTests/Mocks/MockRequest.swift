//
//  MockRequest.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

// Ref: https://jsonplaceholder.typicode.com/comments

// MARK: - MockRequest

enum MockRequest: Request {
    case getComments
    case getPosts
    case dummy
    
    var scheme: String { "https" }
    var host: String {
        switch self {
        case .dummy:
            ""
        default:
            "jsonplaceholder.typicode.com"
        }
    }
    var requestType: RequestType { .get }
    
    var path: String {
        switch self {
        case .getComments:
            "/comments"
        case .getPosts:
            "/posts"
        case .dummy:
            ""
        }
    }
}

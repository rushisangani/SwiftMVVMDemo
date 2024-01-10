//
//  MockRequests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 10/01/2024.
//

import Foundation

struct MockCommentRequest: Request {
    var scheme: String { "https" }
    var host: String { "jsonplaceholder.typicode.com" }
    var path: String { "/comments" }
    
    var url: URL {
        try! createURLRequest().url!
    }
}

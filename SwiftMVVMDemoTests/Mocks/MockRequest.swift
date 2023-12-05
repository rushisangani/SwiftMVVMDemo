//
//  MockRequest.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

// MARK: - MockComments

struct MockCommentsRequest: Request {
    var path: String {
        Bundle.jsonFilePath(forResource: "comments")
    }
}

// MARK: - MockPosts

struct MockPostsRequest: Request {
    var path: String {
        Bundle.jsonFilePath(forResource: "posts")
    }
}

// MARK: - Dummy

struct DummyMockRequest: Request {
    var path: String = ""
}

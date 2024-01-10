//
//  PostServiceTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 05/12/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class PostServiceTests: XCTestCase {
    var postService: PostService?

    override func setUpWithError() throws {
        postService = PostService(apiManager: MockAPIManager())
    }

    override func tearDownWithError() throws {
        postService = nil
    }

    func testPostServiceGetPosts() async throws {
        let posts = try await postService!.getPosts()
        
        let firstPost = try XCTUnwrap(posts.first)
        XCTAssertEqual(firstPost.id, 1)
        XCTAssertEqual(firstPost.userId, 1)
        XCTAssertEqual(firstPost.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        
        let lastPost = try XCTUnwrap(posts.last)
        XCTAssertEqual(lastPost.id, 100)
        XCTAssertEqual(lastPost.userId, 10)
        XCTAssertEqual(lastPost.title, "at nam consequatur ea labore ea harum")
    }
    
    func testPostServiceThrowsError() async throws {
        // TODO: How to implement this?
    }
}

// MARK: - Mock

fileprivate class MockAPIManager: APIService {
    
    func fetch<T: Codable>(request: Request) async throws -> T {
        try Bundle.main.decodableObject(forResource: "posts", type: T.self)
    }
}

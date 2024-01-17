//
//  PostServiceTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 05/12/2023.
//

import XCTest
import NetworkKit
import Combine
@testable import SwiftMVVMDemo

final class PostServiceTests: XCTestCase {
    var postService: PostService?

    override func setUpWithError() throws {
        postService = PostService(networkManager: MockNetworkManager())
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

fileprivate class MockNetworkManager: NetworkHandler {
    
    func fetch<T>(request: Request) async throws -> T where T : Decodable {
        try Bundle.test.decodableObject(forResource: "posts", type: T.self)
    }
    
    func fetch<T>(request: Request) -> AnyPublisher<T, RequestError> where T : Decodable {
        do {
            let posts = try Bundle.test.decodableObject(forResource: "posts", type: T.self)
            return Just(posts)
                .setFailureType(to: RequestError.self)
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: RequestError.failed(description: error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}

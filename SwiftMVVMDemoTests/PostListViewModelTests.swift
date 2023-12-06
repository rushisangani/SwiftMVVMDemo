//
//  PostListViewModelTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 06/12/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class PostListViewModelTests: XCTestCase {
    var postListViewModel: PostListViewModelHandler?
    
    override func setUpWithError() throws {
        postListViewModel = PostListViewModel(postService: MockPostService())
    }

    override func tearDownWithError() throws {
        postListViewModel = nil
    }

    func testPostViewModelReturnsPosts() async throws {
        await postListViewModel!.loadPosts()
        let posts = postListViewModel!.posts
        
        XCTAssertEqual(posts.count, 3)
        
        let first = try XCTUnwrap(posts.first)
        XCTAssertEqual(first.userId, 1)
        XCTAssertEqual(first.id, 1)
        
        let last = try XCTUnwrap(posts.last)
        XCTAssertEqual(last.title, "Post 3")
        XCTAssertEqual(last.body, "Body 3")
    }
}


// MARK: - Mock

class MockPostService: PostRetrievalService {
    private var posts: [Post] = [
        Post(userId: 1, id: 1, title: "Post 1", body: "Body 1"),
        Post(userId: 1, id: 2, title: "Post 2", body: "Body 2"),
        Post(userId: 2, id: 3, title: "Post 3", body: "Body 3")
    ]
    
    func getPosts() async throws -> [Post] {
        posts
    }
    
    func getPostById(_ id: Int) async throws -> Post? {
        posts.first
    }
}

//
//  PostListViewModelTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 06/12/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class PostListViewModelTests: XCTestCase {
    var postListViewModel: PostListViewModel?
    
    override func setUpWithError() throws {
        postListViewModel = PostListViewModel(postService: MockPostService())
    }

    override func tearDownWithError() throws {
        postListViewModel = nil
    }

    func testPostViewModelReturnsPosts() async throws {
        try await postListViewModel!.loadPosts()
        let posts = postListViewModel!.posts
        
        // verify count
        XCTAssertEqual(posts.count, 100)
        
        let first = try XCTUnwrap(posts.first)
        XCTAssertEqual(first.userId, 1)
        XCTAssertEqual(first.id, 1)
        
        let last = try XCTUnwrap(posts.last)
        XCTAssertEqual(last.title, "at nam consequatur ea labore ea harum")
        XCTAssertEqual(last.body, "cupiditate quo est a modi nesciunt soluta\nipsa voluptas error itaque dicta in\nautem qui minus magnam et distinctio eum\naccusamus ratione error aut")
    }
}


// MARK: - Mock

class MockPostService: PostRetrievalService {
    
    func getPosts() async throws -> [Post] {
        try Bundle.main.decodableObject(forResource: "posts", type: [Post].self)
    }
    
    func getPostById(_ id: Int) async throws -> Post? {
        nil
    }
}

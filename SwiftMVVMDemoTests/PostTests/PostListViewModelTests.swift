//
//  PostListViewModelTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 06/12/2023.
//

import XCTest
import Combine
@testable import SwiftMVVMDemo

final class PostListViewModelTests: XCTestCase {
    var postListViewModel: PostListViewModel?
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        postListViewModel = PostListViewModel(postService: MockPostService())
        cancellables = []
    }

    override func tearDownWithError() throws {
        postListViewModel = nil
        cancellables = nil
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
    
    func testPostsProperty() async throws {
        let expectation = XCTestExpectation(description: "@Published posts count")
        
        postListViewModel!
            .$posts
            .dropFirst()
            .sink(receiveValue: { posts in
                // verify count and fullfil the expectation
                XCTAssertEqual(posts.count, 100)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        try await postListViewModel!.loadPosts()
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testPostViewModelFailedGettingPosts() {
        // TODO: How to implement this?
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

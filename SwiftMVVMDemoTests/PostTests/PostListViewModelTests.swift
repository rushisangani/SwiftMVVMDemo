//
//  PostListViewModelTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 06/12/2023.
//

import XCTest
import Combine
import NetworkKit
@testable import SwiftMVVMDemo

final class PostListViewModelTests: XCTestCase {
    var postListViewModel: PostListViewModel!
    var postService: MockPostService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        postService = MockPostService()
        postListViewModel = PostListViewModel(postService: postService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        postListViewModel = nil
        postService = nil
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
    
    func testPostsProperty() throws {
        let expectation = XCTestExpectation(description: "@Published posts count")
        
        // initial state
        XCTAssertTrue(postListViewModel!.posts.isEmpty)
        
        postListViewModel!
            .$posts
            .dropFirst()
            .sink(receiveValue: { posts in
                // verify count and fullfil the expectation
                XCTAssertEqual(posts.count, 100)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        Task {
            try await postListViewModel!.loadPosts()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testPostViewModelFailedGettingPosts() async {
        postService.shouldFail = true
        
        do {
            try await postListViewModel!.loadPosts()
            XCTFail("PostListViewModel should throw error.")
        }
        catch RequestError.failed(let error) {
            XCTAssertEqual(error, "No posts found.")
        } 
        catch {
            XCTFail("PostListViewModel should throw RequestError.failed")
        }
    }
}


// MARK: - Mock

class MockPostService: PostRetrievalService {
    var shouldFail: Bool = false
    
    func getPosts() async throws -> [Post] {
        guard !shouldFail else {
            throw RequestError.failed(description: "No posts found.")
        }
        return try Bundle.test.decodableObject(forResource: "posts", type: [Post].self)
    }
    
    func getPostById(_ id: Int) async throws -> Post? {
        nil
    }
}

//
//  PostListViewControllerTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 06/12/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class PostListViewControllerTests: XCTestCase {
    var postListVC: PostListViewController!
    var viewModel: PostListViewModel!
    
    override func setUpWithError() throws {
        viewModel = PostListViewModel(postService: MockPostService())
        postListVC = PostListViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        postListVC = nil
        viewModel = nil
    }

    func testPostListVCShowPostsInTableView() throws {
        let expectation = XCTestExpectation(description: "TableView has data")
        
        postListVC.loadView()
        postListVC.setupObservers()
        
        Task {
            do {
                try await viewModel.loadPosts()
                expectation.fulfill()
            }
            catch {
                XCTFail("Expected viewmodel should load posts")
            }
        }
        
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(viewModel.posts.count, postListVC.tableView.numberOfRows(inSection: 0))
    }

}

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
    
    override func setUpWithError() throws {
        postListVC = PostListViewController(viewModel: MockPostListViewModel())
    }

    override func tearDownWithError() throws {
        postListVC = nil
    }

    func testPostListVCShowPostsInTableView() async throws {
//        postListVC.loadViewIfNeeded()
//        
//        let viewModel = postListVC.viewModel
//        let tableView = postListVC.tableView
//        
//        
//        let expectation = XCTestExpectation(description: "TableView has data")
//        
//        await XCTAssertEqual(viewModel.posts.count, tableView.numberOfRows(inSection: 0))
    }

}

// MARK: - Mock

class MockPostListViewModel: PostListViewModelHandler {
    var posts: [Post] = []
    
    func loadPosts() async throws {
        let filePath = Bundle.jsonFilePath(forResource: "posts")
        let data = try Data(contentsOf: URL(filePath: filePath))
        let list = try JSONDecoder().decode([Post].self, from: data)
        posts.append(contentsOf: list)
    }
    
    func post(atIndexPath indexPath: IndexPath) -> Post {
        posts[indexPath.row]
    }
}

//
//  PostListViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation
import Combine

protocol PostListViewModelHandler: AnyObject {
    var posts: [Post] { get }
    func loadPosts() async throws
    func post(atIndexPath indexPath: IndexPath) -> Post
}

// MARK: - PostListViewModel

final class PostListViewModel: PostListViewModelHandler {
    private let postService: PostRetrievalService
    
    init(postService: PostRetrievalService = PostService()) {
        self.postService = postService
    }
    
    // MARK: - Properties
    
    var posts: [Post] = []
    
    @MainActor
    func loadPosts() async throws {
        posts = try await postService.getPosts()
    }
    
    func post(atIndexPath indexPath: IndexPath) -> Post {
        posts[indexPath.row]
    }
}

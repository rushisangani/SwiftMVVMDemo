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
    func loadPosts()
    func post(atIndexPath indexPath: IndexPath) -> Post
}

protocol PostListViewDelegate: AnyObject {
    func reloadData()
    func showError(_ error: Error)
}

// MARK: - PostListViewModel

final class PostListViewModel: PostListViewModelHandler {
    private let postService: PostRetrievalService
    
    init(postService: PostRetrievalService = PostService()) {
        self.postService = postService
    }
    
    // MARK: - Properties
    weak var viewDelegate: PostListViewDelegate?
    
    var posts: [Post] = []
    
    @MainActor
    func loadPosts() {
        Task {
            do {
                self.posts = try await postService.getPosts()
                viewDelegate?.reloadData()
            }
            catch {
                viewDelegate?.showError(error)
            }
        }
    }
    
    func post(atIndexPath indexPath: IndexPath) -> Post {
        posts[indexPath.row]
    }
}

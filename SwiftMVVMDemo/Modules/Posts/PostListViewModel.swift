//
//  PostListViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation
import Combine

// MARK: - PostListViewModel

final class PostListViewModel: ObservableObject {
    private let postService: PostRetrievalService
    
    init(postService: PostRetrievalService = PostService()) {
        self.postService = postService
    }
    
    // MARK: - Properties
    
    @Published var posts: [Post] = []
    
    func loadPosts() async throws {
        let _posts = try await postService.getPosts()
        await MainActor.run {
            self.posts = _posts
        }
    }
    
    func post(atIndexPath indexPath: IndexPath) -> Post {
        posts[indexPath.row]
    }
}

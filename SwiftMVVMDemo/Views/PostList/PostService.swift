//
//  PostService.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

protocol PostRetrievalService {
    func getPosts() async throws -> [Post]
    func getPostById(_ id: Int) async throws -> Post?
}

// MARK: - PostService

class PostService: PostRetrievalService {
    let apiManager: APIService
    // let dbManager: DBService
    
    init(apiManager: APIService = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getPosts() async throws -> [Post] {
        // TODO: Get posts from db if network not available
        try await apiManager.fetch(request: PostRequest.getPosts)
    }
    
    func getPostById(_ id: Int) async throws -> Post? {
        try await apiManager.fetch(request: PostRequest.getPost(id: id))
    }
}

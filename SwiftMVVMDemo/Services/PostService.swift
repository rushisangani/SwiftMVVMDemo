//
//  PostService.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

enum PostRequest: Request {
    case postList
    case post(id: Int)
    
    var path: String {
        switch self {
        case .postList:
            return "/posts"
        case .post(let id):
            return "/posts/\(id)"
        }
    }
}

protocol PostAPIService {
    var apiService: APIServiceHandler { get set }
    func getPosts() async throws -> [Post]
    func getPostById(_ id: Int) async throws -> Post
}

class PostService: PostAPIService {
    var apiService: APIServiceHandler = APIService()
    
    func getPosts() async throws -> [Post] {
        try await apiService.fetch(request: PostRequest.postList)
    }
    
    func getPostById(_ id: Int) async throws -> Post {
        try await apiService.fetch(request: PostRequest.post(id: id))
    }
}

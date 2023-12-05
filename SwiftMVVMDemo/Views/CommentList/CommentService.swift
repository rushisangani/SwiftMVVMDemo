//
//  CommentService.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

// MARK: - CommentService

protocol CommentRetrievalService {
    func getComments() async throws -> [Comment]
}

//class CommentService: CommentRetrievalService {
//    private let apiManager: APIService
//    
//    init(apiManager: APIService = APIManager()) {
//        self.apiManager = apiManager
//    }
//    
//    func getComments() async throws -> [Comment] {
//        try await fetch(request: CommentsRequest.commentList)
//    }
//}

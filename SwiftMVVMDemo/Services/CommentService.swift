//
//  CommentService.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

enum CommentsRequest: Request {
    case commentList
    
    var path: String {
        switch self {
        case .commentList:
            return "/comments"
        }
    }
}

protocol CommentAPIService {
    var apiService: APIServiceHandler { get set }
    func getComments() async throws -> [Comment]
}

class CommentService: CommentAPIService {
    var apiService: APIServiceHandler = APIService()
    
    func getComments() async throws -> [Comment] {
        try await apiService.fetch(request: CommentsRequest.commentList)
    }
}

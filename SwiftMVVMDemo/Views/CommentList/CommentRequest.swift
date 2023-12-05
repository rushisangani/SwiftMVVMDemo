//
//  CommentRequest.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

// MARK: - CommentRequest

enum CommentRequest: Request {
    case commentList
    
    var path: String {
        switch self {
        case .commentList:
            return "/comments"
        }
    }
}

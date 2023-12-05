//
//  PostListViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

protocol PostListViewDelegate: AnyObject {
    
}

// MARK: - PostListViewModel

class PostListViewModel: PostService {
    
    // MARK: - Properties

    weak var viewDelegate: PostListViewDelegate?
    private var posts: [Post] = []
}

//
//  PostListView.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 07/12/2023.
//

import SwiftUI

struct PostListView: View {
    @StateObject var viewModel: PostListViewModel
    
    init(postService: PostRetrievalService = PostService()) {
        self._viewModel = StateObject(wrappedValue: PostListViewModel(postService: postService))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.posts) {
                PostListRow(post: $0)
            }
        }
        .task {
            try? await viewModel.loadPosts()
        }
        .listStyle(.plain)
        .navigationTitle(Text("SwiftUI Posts"))
    }
}

struct PostListRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(post.title)
                .font(.body)
                .lineLimit(2)
            Text(post.body)
                .font(.caption)
        }
    }
}

#Preview {
    PostListView()
}

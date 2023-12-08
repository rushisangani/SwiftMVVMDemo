//
//  PhotosAsyncImageView.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import SwiftUI

struct PhotosAsyncImageView: View {
    @StateObject var viewModel: PhotosViewModel
    
    init(photoService: PhotoRetrievalService = PhotoService()) {
        self._viewModel = StateObject(wrappedValue: PhotosViewModel(service: photoService))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.photos) {
                    AsyncImage(url: URL(string: $0.url)) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 300)
                }
            }
        }
        .navigationTitle(Text("SwiftUI Lazy Photos"))
        .task {
            try? await viewModel.getPhotos()
        }
    }
}

#Preview {
    PhotosAsyncImageView()
}

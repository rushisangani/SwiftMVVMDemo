//
//  PhotosCustomAsyncImageView.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import SwiftUI

struct PhotosCustomAsyncImageView: View {
    @StateObject var viewModel: PhotosViewModel
    
    init(photoService: PhotoRetrievalService = PhotoService()) {
        self._viewModel = StateObject(wrappedValue: PhotosViewModel(service: photoService))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.photos) {
                    CustomAsyncImageView(url: $0.url)
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
    PhotosCustomAsyncImageView()
}

struct CustomAsyncImageView: View {
    private let url: String
    
    @State private var image: UIImage?
    private let viewModel = PhotoRowViewModel()
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 300)
            } else {
                ProgressView()
                    .frame(height: 300)
            }
        }
        .onAppear() {
            viewModel.getImage(url: url)
        }
        .onReceive(viewModel.image) { image in
            self.image = image
        }
    }
}

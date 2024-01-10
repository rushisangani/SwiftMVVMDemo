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
    @StateObject var imageService = ImageService()
    @State var image: UIImage?
    private let url: String
    
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
            imageService.getImage(from: url)
        }
    }
}

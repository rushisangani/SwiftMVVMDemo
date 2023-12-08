//
//  PhotosViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation
import Combine
import UIKit

final class PhotosViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [Photo] = []
    @Published var images: [String: UIImage] = [:]
    
    private let imageLoader = ImageLoader()
    private var cancellables = Set<AnyCancellable>()
    
    let service: PhotoRetrievalService
    
    init(service: PhotoRetrievalService = PhotoService()) {
        self.service = service
        
        imageLoader
            .$imageInfo
            .sink { [weak self] info in
                self?.images[info.url] = info.image
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func getPhotos() async throws {
        photos = try await service.getPhotos(albumId: 1)
    }
    
    func photoURL(atIndexPath indexPath: IndexPath) -> String {
        photos[indexPath.row].url
    }
    
    func image(atIndexPath indexPath: IndexPath) -> UIImage? {
        let url = photoURL(atIndexPath: indexPath)
        return images[url]
    }
    
    func downloadImage(atIndexPath indexPath: IndexPath) {
        imageLoader.getImage(url: photoURL(atIndexPath: indexPath))
    }
}

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
    let imagePublisher = PassthroughSubject<(UIImage, IndexPath), Never>()
    private var cancellables = Set<AnyCancellable>()
    
    let service: PhotoRetrievalService
    var imageService: ImageServiceProtocol?
    
    init(service: PhotoRetrievalService = PhotoService(),
         imageService: ImageService = ImageService()
    ) {
        self.service = service
        self.imageService = imageService
    }
    
    @MainActor
    func getPhotos() async throws {
        photos = try await service.getPhotos(albumId: 1)
    }
    
    func image(atIndexPath indexPath: IndexPath) -> UIImage? {
        imageService?.cachedImage(for: photoUrl(at: indexPath))
    }
    
    func downloadImage(atIndexPath indexPath: IndexPath) {
        let photoUrl = photoUrl(at: indexPath)
        
//        imageService
//        
//        imageService?
//            .download(from: photoUrl)
//        
//        
//        imageLoader?
//            .downloadImage(url: photo.url)
//            .sink { _ in
//            } receiveValue: { [weak self] image in
//                if let image = image {
//                    self?.imageCache?[photo.url] = image
//                    self?.imagePublisher.send((image, indexPath))
//                }
//            }
//            .store(in: &cancellables)
    }
}

private extension PhotosViewModel {
    
    func photoUrl(at indexPath: IndexPath) -> String {
        photos[indexPath.row].url
    }
}

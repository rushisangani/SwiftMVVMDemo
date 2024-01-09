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
    lazy var imagePublisher = PassthroughSubject<(UIImage, IndexPath), Never>()
    private var cancellables = Set<AnyCancellable>()
    
    let service: PhotoRetrievalService
    var imageService: ImageServiceProtocol?
    
    init(service: PhotoRetrievalService = PhotoService(),
         imageService: ImageServiceProtocol? = nil
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
        Task {
            if let image = await imageService?.downloadWithAsync(from: photoUrl) {
                self.imagePublisher.send((image, indexPath))
            }
        }
    }
}

private extension PhotosViewModel {
    
    func photoUrl(at indexPath: IndexPath) -> String {
        photos[indexPath.row].url
    }
}

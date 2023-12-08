//
//  PhotosViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation
import Combine

final class PhotosViewModel {
    let service: PhotoRetrievalService
    
    init(service: PhotoRetrievalService = PhotoService()) {
        self.service = service
    }
    
    // MARK: - Properties
    
    @Published var photos: [Photo] = []
    
    @MainActor
    func getPhotos() async throws {
        photos = try await service.getPhotos(albumId: 1)
    }
    
    func photo(atIndexPath indexPath: IndexPath) -> Photo {
        photos[indexPath.row]
    }
}

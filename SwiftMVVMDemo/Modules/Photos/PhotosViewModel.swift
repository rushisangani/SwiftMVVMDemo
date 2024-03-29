//
//  PhotosViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation
import UIKit

final class PhotosViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [Photo] = []
    private let service: PhotoRetrievalService
    
    init(service: PhotoRetrievalService = PhotoService()) {
        self.service = service
    }
    
    func getPhotos() async throws {
        let _photos = try await service.getPhotos(albumId: 1)
        await MainActor.run {
            self.photos = _photos
        }
    }
    
    func photoUrl(at indexPath: IndexPath) -> String {
        photos[indexPath.row].url
    }
}

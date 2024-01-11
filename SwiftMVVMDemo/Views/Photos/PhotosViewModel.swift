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
    let service: PhotoRetrievalService
    
    init(service: PhotoRetrievalService = PhotoService()) {
        self.service = service
    }
    
    @MainActor
    func getPhotos() async throws {
        photos = try await service.getPhotos(albumId: 1)
    }
    
    func photoUrl(at indexPath: IndexPath) -> String {
        photos[indexPath.row].url
    }
}

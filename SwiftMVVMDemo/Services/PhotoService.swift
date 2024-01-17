//
//  PhotoService.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation
import NetworkKit

enum PhotoRequest: Request {
    case photosByAlbum(id: Int)
    
    var path: String {
        switch self {
        case .photosByAlbum(let id):
            return "/albums/\(id)/photos"
        }
    }
}

protocol PhotoRetrievalService {
    func getPhotos(albumId: Int) async throws -> [Photo]
}

// MARK: - PhotoService

class PhotoService: PhotoRetrievalService {
    let networkManager: NetworkHandler
    
    init(networkManager: NetworkHandler = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getPhotos(albumId: Int) async throws -> [Photo] {
        try await networkManager.fetch(request: PhotoRequest.photosByAlbum(id: albumId))
    }
}

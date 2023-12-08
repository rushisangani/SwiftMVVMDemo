//
//  PhotoService.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation

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
    let apiManager: APIService
    
    init(apiManager: APIService = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getPhotos(albumId: Int) async throws -> [Photo] {
        try await apiManager.fetch(request: PhotoRequest.photosByAlbum(id: albumId))
    }
}

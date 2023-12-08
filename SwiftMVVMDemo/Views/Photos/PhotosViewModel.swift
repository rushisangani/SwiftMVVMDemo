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
    
//    private var imageDownloader = ImageDownloader()
//    private var cancellables = Set<AnyCancellable>()
//    private var downloadTasks: [String: AnyCancellable] = [:]
    
    let service: PhotoRetrievalService
    
    init(service: PhotoRetrievalService = PhotoService()) {
        self.service = service
    }
    
    @MainActor
    func getPhotos() async throws {
        photos = try await service.getPhotos(albumId: 1)
    }
    
    func photo(atIndexPath indexPath: IndexPath) -> Photo {
        photos[indexPath.row]
    }
    
//    func downloadImage(fromURL url: String) {
//        downloadTasks[url] = imageDownloader.getImage(fromUrl: url)
//    }
//    
//    func cancelDownload(atIndexPath indexPath: IndexPath) {
//        let url = photo(atIndexPath: indexPath).url
//        downloadTasks[url]?.cancel()
//    }
}

//extension PhotosViewModel {
//    
//    func handleOnReceiveImage() {
//        imageDownloader
//            .imagePublisher
//            .sink(receiveValue: { [weak self] (image, url) in
//                self?.images[url] = image
//            })
//            .store(in: &cancellables)
//    }
//}

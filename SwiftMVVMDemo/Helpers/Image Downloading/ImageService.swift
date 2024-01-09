//
//  ImageService.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 09/01/2024.
//

import Foundation
import UIKit
import Combine

protocol ImageServiceProtocol {
    
    /// Get cached image for specified url
    /// returns nil if image not available in cache
    func cachedImage(for url: String) -> UIImage?
    
    /// Downloads image from specified url
    func download(from url: String)
    
    /// Returns cached image if available, othewise download from url
    func getImage(from url: String)
    
    /// Save provided image to cache, remove otherwise
    func save(image: UIImage?, forUrl url: String)
}

class ImageService: ImageServiceProtocol, ObservableObject {
    
    // MARK: - Properties
    
    @Published var image: UIImage? = nil
    private var cancellables = Set<AnyCancellable>()
    
    let imageDownloader: AsyncImageLoading
    let imageCache: ImageCache
    
    // MARK: - Init
    
    init(imageDownloader: AsyncImageLoading = AsyncImageLoader(),
         imageCache: ImageCache = .shared
    ) {
        self.imageDownloader = imageDownloader
        self.imageCache = imageCache
    }
    
    // MARK: - ImageServiceProtocol
    
    func cachedImage(for url: String) -> UIImage? {
        imageCache[url]
    }
    
    func download(from url: String) {
        imageDownloader
            .downloadImage(url: url)
            .sink { _ in
            } receiveValue: { [weak self] image in
                self?.image = image
                self?.save(image: image, forUrl: url)
                print("Finish for: \(url)")
            }
            .store(in: &cancellables)
    }
    
    func getImage(from url: String) {
        // from cache
        if let image = cachedImage(for: url) {
            self.image = image
            return
        }
        
        // download
        download(from: url)
    }
    
    func save(image: UIImage?, forUrl url: String) {
        imageCache[url] = image
    }
}

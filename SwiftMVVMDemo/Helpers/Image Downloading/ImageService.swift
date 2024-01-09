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
    
    /// Downloads image using Combine from specified url
    func downloadWithCombine(from url: String)
    
    /// Downloads image using Async from specified url
    func downloadWithAsync(from url: String) async -> UIImage?
    
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
    
    func downloadWithCombine(from url: String) {
        imageDownloader
            .downloadWithCombine(url: url)
            .sink { _ in
            } receiveValue: { [weak self] image in
                self?.image = image
                self?.save(image: image, forUrl: url)
            }
            .store(in: &cancellables)
    }
    
    func downloadWithAsync(from url: String) async -> UIImage? {
        do {
            let image = try await imageDownloader.downloadWithAsync(url: url)
            save(image: image, forUrl: url)
            return image
        } 
        catch {
            return nil
        }
    }
    
    func getImage(from url: String) {
        // from cache
        if let image = cachedImage(for: url) {
            self.image = image
            return
        }
        
        // download
        downloadWithCombine(from: url)
    }
    
    func save(image: UIImage?, forUrl url: String) {
        imageCache[url] = image
    }
}

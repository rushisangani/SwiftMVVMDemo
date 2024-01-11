//
//  PhotoRowViewModel.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 11/01/2024.
//

import Foundation
import Combine
import UIKit

protocol PhotoRowViewModelHandler {
    
    var imagePublisher: Published<UIImage?>.Publisher { get }
    func getImage(url: String)
    func downloadImage(url: String)
}

class PhotoRowViewModel: ObservableObject, PhotoRowViewModelHandler {
    
    // MARK: - Properties
    
    @Published var image: UIImage? = nil
    var imagePublisher: Published<UIImage?>.Publisher { $image } 
    private var cancellables = Set<AnyCancellable>()
    
    let imageLoader: AsyncImageLoading
    let cacheManager: Cacheable
    
    init(imageLoader: AsyncImageLoading = AsyncImageLoader(),
         cacheManager: Cacheable = CacheManager.shared
    ) {
        self.imageLoader = imageLoader
        self.cacheManager = cacheManager
    }
    
    // MARK: - PhotoRowViewModelHandler
    
    func getImage(url: String) {
        if let image = cacheManager[url] {
            self.image = image
        } else {
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: String) {
        imageLoader
            .downloadWithCombine(url: url)
            .sink { _ in
            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                
                self.cacheManager.set(image, for: url)
                self.image = image
            }
            .store(in: &cancellables)
    }
}

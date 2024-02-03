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
    
    var image: CurrentValueSubject<UIImage?, Never> { get }
    func getImage(url: String)
    func downloadImage(url: String)
}

class PhotoRowViewModel: PhotoRowViewModelHandler {
    
    // MARK: - Properties
    
    var image = CurrentValueSubject<UIImage?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    
    private let imageLoader: AsyncImageLoading
    private let cacheManager: Cacheable
    
    init(imageLoader: AsyncImageLoading = AsyncImageLoader(),
         cacheManager: Cacheable = CacheManager.shared
    ) {
        self.imageLoader = imageLoader
        self.cacheManager = cacheManager
    }
    
    // MARK: - PhotoRowViewModelHandler
    
    func getImage(url: String) {
        if let image = cacheManager[url] {
            self.image.send(image)
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
                self.image.send(image)
            }
            .store(in: &cancellables)
    }
}

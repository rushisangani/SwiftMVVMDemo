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
    func getImage()
    func downloadImage()
}

class PhotoRowViewModel: ObservableObject, PhotoRowViewModelHandler {
    
    // MARK: - Properties
    
    @Published var image: UIImage? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private let url: String
    private let imageLoader: AsyncImageLoading
    private let cacheManager: Cacheable
    
    init(url: String,
         imageLoader: AsyncImageLoading = AsyncImageLoader(),
         cacheManager: Cacheable = CacheManager.shared
    ) {
        self.url = url
        self.imageLoader = imageLoader
        self.cacheManager = cacheManager
    }
    
    // MARK: - PhotoRowViewModelHandler
    
    func getImage() {
        if let image = cacheManager[url] {
            self.image = image
        } else {
            downloadImage()
        }
    }
    
    func downloadImage() {
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

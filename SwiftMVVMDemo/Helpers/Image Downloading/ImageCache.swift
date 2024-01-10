//
//  AsyncImageCache.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 09/01/2024.
//

import Foundation
import UIKit

protocol ImageCaching {
    func get(for url: String) -> UIImage?
    func set(_ image: UIImage?, for url: String)
}

final class ImageCache: ImageCaching {
    
    // MARK: - Singleton
    
    public static let shared = ImageCache()
    private init() {}
    
    // MARK: - Properties
    
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    subscript(key: String) -> UIImage? {
        get { get(for: key) }
        set { set(newValue, for: key) }
    }
    
    // MARK: - ImageCaching
    
    func get(for url: String) -> UIImage? {
        cache.object(forKey: url as NSString)
    }
    
    func set(_ image: UIImage?, for url: String) {
        if image == nil {
            cache.removeObject(forKey: url as NSString)
        } else {
            cache.setObject(image!, forKey: url as NSString)
        }
    }
}

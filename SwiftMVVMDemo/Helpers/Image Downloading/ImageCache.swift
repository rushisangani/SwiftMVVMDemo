//
//  AsyncImageCache.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 09/01/2024.
//

import Foundation
import UIKit

final class ImageCache {
    
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
        get {
            cache.object(forKey: key as NSString)
        }
        set {
            if newValue == nil {
                cache.removeObject(forKey: key as NSString)
            } else {
                cache.setObject(newValue!, forKey: key as NSString)
            }
        }
    }
}

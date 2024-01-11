//
//  CacheManager.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 09/01/2024.
//

import Foundation
import UIKit

protocol Cacheable {
    func get(for url: String) -> UIImage?
    func set(_ image: UIImage?, for url: String)
    subscript(key: String) -> UIImage? { get set }
}

final class CacheManager: Cacheable {
    
    // MARK: - Singleton
    
    public static let shared = CacheManager()
    private init() {}
    
    // MARK: - Properties
    
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    // MARK: - Cacheable
    
    subscript(key: String) -> UIImage? {
        get { get(for: key) }
        set { set(newValue, for: key) }
    }
    
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

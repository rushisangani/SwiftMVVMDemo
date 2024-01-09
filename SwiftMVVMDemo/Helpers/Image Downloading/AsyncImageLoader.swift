//
//  AsyncImageLoader.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation
import UIKit
import Combine

protocol AsyncImageLoading {
    func downloadWithCombine(url: String) -> AnyPublisher<UIImage?, Error>
    func downloadWithAsync(url: String) async throws -> UIImage?
}

class AsyncImageLoader: ObservableObject, AsyncImageLoading {
    private static let queue = DispatchQueue(label: "Image Download Queue")
    
    /// Using Combine
    func downloadWithCombine(url: String) -> AnyPublisher<UIImage?, Error>  {
        guard let imageURL = URL(string: url) else {
            return Fail(error: NSError(domain: "Incorrect URL", code: -1001)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .subscribe(on: Self.queue)
            .map { UIImage(data: $0.data) }
            .mapError { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Using Async-Await
    func downloadWithAsync(url: String) async throws -> UIImage? {
        guard let imageURL = URL(string: url) else {
            throw NSError(domain: "Incorrect URL", code: -1001)
        }
        
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return UIImage(data: data)
        } catch {
            throw error
        }
    }
}

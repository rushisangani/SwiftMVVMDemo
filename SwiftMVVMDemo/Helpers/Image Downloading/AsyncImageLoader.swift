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
    func downloadWithCombine(url: String) -> AnyPublisher<UIImage, Error>
    func downloadWithAsync(url: String) async throws -> UIImage
}

class AsyncImageLoader: ObservableObject, AsyncImageLoading {
    
    // MARK: - Properties
    
    private static let queue = DispatchQueue(label: "Image Download Queue")
    private let urlSession: URLSession

    // MARK: - Init
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Using Combine
    func downloadWithCombine(url: String) -> AnyPublisher<UIImage, Error>  {
        guard let imageURL = URL(string: url) else {
            return Fail(error: URLError(.badURL, userInfo: [NSURLErrorFailingURLErrorKey: url]))
                .eraseToAnyPublisher()
        }
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad)
        
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: Self.queue)
            .map(\.data)
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw URLError(.badServerResponse, userInfo: [NSURLErrorFailingURLErrorKey: url])
                }
                return image
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Using Async-Await
    func downloadWithAsync(url: String) async throws -> UIImage {
        guard let imageURL = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad)
        let (data, _) = try await urlSession.data(for: request)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse, userInfo: [NSURLErrorFailingURLErrorKey: url])
        }
        return image
    }
}

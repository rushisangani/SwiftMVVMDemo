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
    func downloadImage(url: String) -> AnyPublisher<UIImage?, Error>
}

class AsyncImageLoader: ObservableObject, AsyncImageLoading {
    private static let queue = DispatchQueue(label: "Image Download Queue")
    
    // Download From Remote URL
    func downloadImage(url: String) -> AnyPublisher<UIImage?, Error>  {
        guard let imageURL = URL(string: url) else {
            return Fail(error: NSError(domain: "Incorrect URL", code: -1001)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad)
        print("Start for: \(url)")
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .subscribe(on: Self.queue)
            .map { UIImage(data: $0.data) }
            .mapError { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

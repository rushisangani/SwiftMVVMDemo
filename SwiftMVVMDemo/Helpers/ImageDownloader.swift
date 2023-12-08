//
//  ImageDownloadOperation.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Combine
import UIKit

final class ImageDownloader {
    
    let imagePublisher = PassthroughSubject<(UIImage?, String), Never>()
    
    func getImage(fromUrl url: String) -> AnyCancellable? {
        guard let imageURL = URL(string: url) else {
            return nil
        }
        let cancellable = URLSession.shared
            .dataTaskPublisher(for: imageURL)
            .map(\.data)
            .sink { _ in
                
            } receiveValue: { [unowned self] data in
                if let image = UIImage(data: data) {
                    imagePublisher.send((image, url))
                }
            }
        
        return cancellable
    }
}

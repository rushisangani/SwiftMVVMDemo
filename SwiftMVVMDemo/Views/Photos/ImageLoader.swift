//
//  ImageLoader.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import Foundation
import UIKit
import Combine

struct ImageInfo {
    var image: UIImage?
    var url: String
}

class ImageLoader: ObservableObject {
    
    @Published var imageInfo: ImageInfo = .init(image: nil, url: "")
    private var cancellables = Set<AnyCancellable>()
    
    func getImage(url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad)
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: RunLoop.main)
            .sink { _ in
                
            } receiveValue: { [weak self] data in
                if let image = UIImage(data: data) {
                    self?.imageInfo = .init(image: image, url: url)
                }
            }
            .store(in: &cancellables)
    }
}

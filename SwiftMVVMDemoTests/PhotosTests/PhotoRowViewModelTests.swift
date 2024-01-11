//
//  PhotoRowViewModelTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 11/01/2024.
//

import XCTest
import Combine
@testable import SwiftMVVMDemo

final class PhotoRowViewModelTests: XCTestCase {
    var viewModel: PhotoRowViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        viewModel = PhotoRowViewModel(
            imageLoader: MockAsyncImageLoader(),
            cacheManager: MockCacheManager()
        )
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
    }
    
    func testImageDownloadAndCaching() {
        let expectation1 = XCTestExpectation(description: "PhotoRowViewModel downloads image")
        let expectation2 = XCTestExpectation(description: "PhotoRowViewModel caches image")
        
        let imageUrl = "https://via.placeholder.com/150/d32776"
        
        // verify initial state
        XCTAssertNil(viewModel.image)
        XCTAssertNil(viewModel.cacheManager.get(for: imageUrl))
        
        // download
        viewModel.downloadImage(url: imageUrl)
        
        wait(for: [expectation1, expectation2], timeout: 2)
        
        // image must not be nil
        XCTAssertNotNil(viewModel.image)
        expectation1.fulfill()
        
        // image must present in cache
        XCTAssertNotNil(viewModel.cacheManager.get(for: imageUrl))
        expectation2.fulfill()
    }
}

// MARK: - Mocks

class MockAsyncImageLoader: AsyncImageLoading {
    private let sampleImage = UIImage(named: "sample.png")!
    
    func downloadWithCombine(url: String) -> AnyPublisher<UIImage, Error> {
        Just(sampleImage)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync(url: String) async throws -> UIImage {
        sampleImage
    }
}

class MockCacheManager: Cacheable {
    private var cache: Dictionary<String, UIImage> = [:]
    
    func get(for url: String) -> UIImage? {
        cache[url]
    }
    
    func set(_ image: UIImage?, for url: String) {
        cache[url] = image
    }
    
    func clear() {
        cache.removeAll()
    }
}

//
//  AsyncImageLoaderTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 10/01/2024.
//

import XCTest
import Combine
@testable import SwiftMVVMDemo

final class AsyncImageLoaderTests: XCTestCase {
    var asyncImageLoading: AsyncImageLoading?
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        asyncImageLoading = AsyncImageLoader()
        cancellables = []
    }

    override func tearDownWithError() throws {
        asyncImageLoading = nil
    }

    func testImageDownloadingWithCombine() {
//        let expectation = XCTestExpectation(description: "AsyncImageLoader Download Image")
//        
//        asyncImageLoading!
//            .downloadWithCombine(url: MockImage.imageUrl)
//            .sink(receiveCompletion: { completion in
//                guard case .finished = completion else {
//                    return
//                }
//                expectation.fulfill()
//                
//            }, receiveValue: { image in
//                XCTAssertNotNil(image)
//            })
//            .store(in: &cancellables)
//        
//        wait(for: [expectation], timeout: 3)
    }
    
    func testImageDownloadingWithAsync() async throws {
        do {
            let image = try await asyncImageLoading!.downloadWithAsync(url: MockImage.imageUrl)
            XCTAssertNotNil(image)
        } catch {
            XCTFail("AsyncImageLoader should fetch image for valid URL")
        }
    }
    
    func testImageDownloadingFailure() {
        
    }
}

struct MockImage {
    static let imageUrl = "https://via.placeholder.com/151/d32776"
    static let dummy = "https://via.placeholder.com/asd"
}

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
    var asyncImageLoader: AsyncImageLoading!
    var imageUrl: String!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        asyncImageLoader = AsyncImageLoader(urlSession: URLSession.mock)
        
        imageUrl = "https://via.placeholder.com/151/d32776"
        cancellables = []
    }

    override func tearDownWithError() throws {
        asyncImageLoader = nil
        imageUrl = nil
        cancellables = nil
    }

    func testAsyncImageDownloadingWithCombine() {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (MockImage().data, response)
        }
        
        var result: UIImage?
        let expectation = XCTestExpectation(description: "AsyncImageLoader Download Image")
        
        asyncImageLoader!
            .downloadWithCombine(url: imageUrl)
            .sink { completion in
                guard case .finished = completion else { return }
                expectation.fulfill()
                
            } receiveValue: { image in
                result = image
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        // verify image exists
        XCTAssertNotNil(result)
    }
    
    func testAsyncImageLoaderFailureWithCombine() {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (Data(), response)
        }
        
        let expectation = XCTestExpectation(description: "AsyncImageLoader should throw error")
        var result: UIImage?
        var error: Error?
        
        asyncImageLoader!
            .downloadWithCombine(url: imageUrl)
            .sink { completion in
                guard case .failure(let err) = completion else { return }
                error = err
                expectation.fulfill()
                
            } receiveValue: { image in
                result = image
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        // verify image not retrieved
        XCTAssertNil(result)
        
        do {
            // verify error type is badServerResponse
            let urlError = try XCTUnwrap(error as? URLError)
            XCTAssertEqual(urlError.code, URLError.badServerResponse)
            
        } catch {
            XCTFail("AsyncImageLoader unexpected error: \(error)")
        }
    }
    
    func testAsyncImageLoaderReturnsImage() async throws {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (MockImage().data, response)
        }
        
        let sampleImageData = MockImage().data
        let expectation = XCTestExpectation(description: "AsycImageLoader should return image")
        
        do {
            let image = try await asyncImageLoader!.downloadWithAsync(url: imageUrl!)
            expectation.fulfill()
            
            // verify the image is correct
            XCTAssertEqual(image.pngData()!.count, sampleImageData.count)
        }
        catch {
            XCTFail("AsycImageLoader should return valid image with correct url.")
        }
    }
    
    func testAyncImageLoaderFailure() async throws {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (Data(), response)
        }
        
        let expectation = XCTestExpectation(description: "AsycImageLoader should throw badServerResponse error")
        do {
            let _ = try await asyncImageLoader!.downloadWithAsync(url: imageUrl)
            XCTFail("AsyncImageLoader should throw error")
        }
        catch URLError.badServerResponse {
            expectation.fulfill()
        }
    }
}

// MARK: - Mocks

fileprivate struct MockImage {
    var image: UIImage {
        UIImage(named: "sample.png")!
    }
    var data: Data {
        image.pngData()!
    }
}

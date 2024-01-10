//
//  ImageCacheTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 10/01/2024.
//

import XCTest
@testable import SwiftMVVMDemo

final class ImageCacheTests: XCTestCase {
    var imageCache: ImageCaching?
    
    override func setUpWithError() throws {
        imageCache = ImageCache.shared
    }

    override func tearDownWithError() throws {
        imageCache = nil
    }

    func testImageCacheStoreAndRetrieveImages() {
        let image = UIImage(named: "sample.png")!
        let url = "https://via.placeholder.com/150/d32776"
        
        // set
        imageCache!.set(image, for: url)
        // get
        let result = imageCache?.get(for: url)
        XCTAssertNotNil(result, "Expected image not nil")
        XCTAssertEqual(image, result)
    }
}

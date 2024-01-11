//
//  CacheManagerTests.swift
//  SwiftMVVMDemoTests
//
//  Created by Rushi Sangani on 10/01/2024.
//

import XCTest
@testable import SwiftMVVMDemo

final class CacheManagerTests: XCTestCase {
    var cacheManager: Cacheable!
    
    override func setUpWithError() throws {
        cacheManager = CacheManager.shared
    }

    override func tearDownWithError() throws {
        cacheManager = nil
    }

    func testImageCacheStoreAndRetrieveImages() {
        let image = UIImage(named: "sample.png")!
        let url = "https://via.placeholder.com/150/d32776"
        
        // set
        cacheManager.set(image, for: url)
        // get
        let result = cacheManager.get(for: url)
        XCTAssertNotNil(result, "Expected image not nil")
        XCTAssertEqual(image, result)
    }
    
    func testCacheManagerClearCache() {
        let image = UIImage(named: "sample.png")!
        let url = "<some url>"
        
        // set
        cacheManager.set(image, for: url)
        
        // clear
        cacheManager.clear()
        
        let result = cacheManager[url]
        XCTAssertNil(result)
    }
}

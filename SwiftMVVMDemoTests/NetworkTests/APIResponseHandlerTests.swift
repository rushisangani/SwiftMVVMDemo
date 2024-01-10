//
//  APIResponseHandlerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIResponseHandlerTests: XCTestCase {
    var responseHandler: ResponseHandling?
    
    override func setUpWithError() throws {
        responseHandler = APIResponseHandler()
    }

    override func tearDownWithError() throws {
        responseHandler = nil
    }
    
    func testAPIResponseHandlerParseSuccess() throws {
        let response = MockPostResponse()
        
        let result: Post = try responseHandler!.getResponse(from: response.data)
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
    }
    
    func testAPIResponseHandlerParseFailure() throws {
        let response = MockErrorResponse()
        let expectation = XCTestExpectation(description: "APIResponseHandler throws decode error")
        
        do {
            let _: Post = try responseHandler!.getResponse(from: response.data)
            XCTFail("APIResponseHandler should throw decode error")
        }
        catch RequestError.decode {
            expectation.fulfill()
        }
    }
}

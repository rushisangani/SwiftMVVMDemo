//
//  APIResponseHandlerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest

final class APIResponseHandlerTests: XCTestCase {
    
    var responseHandler: ResponseHandler!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        responseHandler = nil
    }
    
    func testAPIResponseHandlerParseSuccess() throws {
        let mockdata = MockResponse.data
        let responseHandler = APIResponseHandler()
        
        let result: Post = try responseHandler.getResponse(from: mockdata)
        XCTAssertTrue(result.id == 1)
        XCTAssertTrue(result.title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
    }
    
    func testAPIResponseHandlerParseFailure() throws {
        let invalidData = MockResponse.dummyData
        let responseHandler = APIResponseHandler()
        
        var result: [Comment]?
        result = try? responseHandler.getResponse(from: invalidData)
        XCTAssertNil(result, "Parse result should be nil")
    }

}



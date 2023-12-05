//
//  APIResponseHandlerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIResponseHandlerTests: XCTestCase {
    var responseHandler: ResponseHandler?
    
    override func setUpWithError() throws {
        responseHandler = APIResponseHandler()
    }

    override func tearDownWithError() throws {
        responseHandler = nil
    }
    
    func testAPIResponseHandlerParseSuccess() throws {
        // post data as mock
        let mockdata = MockResponse.postAsData
        
        let result: Post = try responseHandler!.getResponse(from: mockdata)
        XCTAssertTrue(result.id == 1)
        XCTAssertTrue(result.title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
    }
    
    func testAPIResponseHandlerParseFailure() throws {
        // dummy data as mock
        let invalidData = MockResponse.dummyData
        
        var result: [Comment]?
        result = try? responseHandler!.getResponse(from: invalidData)
        XCTAssertNil(result, "Parse result should be nil")
    }

}


// MARK: - Mocks

struct MockResponse {
    static var postAsData: Data {
        let json = "{\r\n\"userId\": 1,\r\n\"id\": 1,\r\n\"title\": \"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\",\r\n\"body\": \"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\"\r\n}"
        return json.data(using: .utf8)!
    }
    
    static var dummyData: Data {
        "dummyText".data(using: .utf8)!
    }
}

//
//  APIRequestHandlerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIRequestHandlerTests: XCTestCase {
    var requestHandler: RequestHandler?
    
    override func setUpWithError() throws {
        requestHandler = APIRequestHandler()
    }

    override func tearDownWithError() throws {
        requestHandler = nil
    }

    func testAPIRequestHandlerReturnsDataWithValidRequest() async throws {
        // mock request - get comments
        let request: Request = MockRequest.getComments
        
        do {
            let data = try await requestHandler!.fetchData(from: request)
            XCTAssert(!data.isEmpty, "Expected data should not be empty.")
        } 
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAPIRequestHandlerShouldThrowErrorWithInvalidRequest() async throws {
        // dummy request
        let request: Request = MockRequest.dummy
        
        var result: Data?
        result = try? await requestHandler!.fetchData(from: request)
        XCTAssertNil(result, "Dummy request should return nil data.")
    }
}

// MARK: - Mocks
// Ref: https://jsonplaceholder.typicode.com/comments

enum MockRequest: Request {
    case getComments
    case getPosts
    case dummy
    
    var scheme: String { "https" }
    var host: String {
        switch self {
        case .dummy:
            ""
        default:
            "jsonplaceholder.typicode.com"
        }
    }
    var requestType: RequestType { .get }
    
    var path: String {
        switch self {
        case .getComments:
            "/comments"
        case .getPosts:
            "/posts"
        case .dummy:
            ""
        }
    }
}

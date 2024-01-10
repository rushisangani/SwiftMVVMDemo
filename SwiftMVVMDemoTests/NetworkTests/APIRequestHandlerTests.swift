//
//  APIRequestHandlerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIRequestHandlerTests: XCTestCase {
    var requestHandler: RequestHandling?
    var request: MockCommentRequest!
    
    override func setUpWithError() throws {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        requestHandler = APIRequestHandler(session: urlSession)
        request = MockCommentRequest()
    }

    override func tearDownWithError() throws {
        requestHandler = nil
        request = nil
    }

    func testAPIRequestHandlerReturnsData() async throws {
        MockURLProtocol.requestHandler = { request in
            guard request.url == self.request.url else {
                throw RequestError.invalidURL
            }
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (MockCommentResponse().data, response)
        }
        
        let result = try await requestHandler!.fetchData(from: request)
        let resultData = try XCTUnwrap(result)
        
        // verify data exists
        XCTAssertTrue(!resultData.isEmpty)
        
        // verify data correctness
        let comment = try JSONDecoder().decode(Comment.self, from: resultData)
        XCTAssertEqual(comment.id, 11)
        XCTAssertEqual(comment.email, "Veronica_Goodwin@timmothy.net")
    }
    
    func testAPIRequestHandlerThrowsUnAuthorizedError() async throws {
        MockURLProtocol.requestHandler = { request in
            guard request.url == self.request.url else {
                throw RequestError.invalidURL
            }
            let response = HTTPURLResponse(url: request.url!, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (Data(), response)
        }
        
        let expectation = XCTestExpectation(description: "APIRequestHandler throws UnAuthorized error")
        do {
            let _ = try await requestHandler!.fetchData(from: request)
            XCTFail("APIRequestHandler should throw unAuthorized error")
        }
        catch RequestError.unAuthorized {
            expectation.fulfill()
        }
    }
    
    func testAPIRequestHandlerThrowsUnExpectedError() async throws {
        MockURLProtocol.requestHandler = { request in
            guard request.url == self.request.url else {
                throw RequestError.invalidURL
            }
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (Data(), response)
        }
        
        let expectation = XCTestExpectation(description: "APIRequestHandler throws Unexpected error")
        do {
            let _ = try await requestHandler!.fetchData(from: request)
            XCTFail("APIRequestHandler should throw unexpectedStatusCode error")
        }
        catch RequestError.unexpectedStatusCode {
            expectation.fulfill()
        }
    }
}

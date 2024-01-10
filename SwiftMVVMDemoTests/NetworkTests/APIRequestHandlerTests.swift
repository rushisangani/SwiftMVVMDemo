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
        let configuration = URLSessionConfiguration.default
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

// MARK: - MockURLProtocol

class MockURLProtocol: URLProtocol {
    static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (Data, HTTPURLResponse))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        
        do {
            let (data, response) = try handler(request)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
}

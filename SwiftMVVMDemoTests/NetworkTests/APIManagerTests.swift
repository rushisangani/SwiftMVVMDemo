//
//  APIManagerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIManagerTests: XCTestCase {
    var apiManager: APIService!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        apiManager = nil
    }
    
    func testAPIManagerGetComments() async throws {
        apiManager = APIManager(
            requestHandler: MockAPIRequestHandler(shouldSucceed: true),
            responseHandler: MockAPIResponseHandler(shouldSucceed: true)
        )
        
        var comments: [Comment] = []
        let request = MockCommentRequest()
        
        let expectation = XCTestExpectation(description: "APIManager Get Comments")
        do {
            comments = try await apiManager!.fetch(request: request)
            expectation.fulfill()

            // verify data correctness
            let comment = try XCTUnwrap(comments.first)
            XCTAssert(comment.id == 1)
            XCTAssert(comment.name == "id labore ex et quam laborum")
            XCTAssert(comment.email == "Eliseo@gardner.biz")
        }
        catch {
            XCTFail("Expected APIManager should complete fetch request.")
        }
    }
    
    func testAPIManagerThrowsError() async throws {
        apiManager = APIManager(
            requestHandler: MockAPIRequestHandler(shouldSucceed: false),
            responseHandler: MockAPIResponseHandler(shouldSucceed: false)
        )
        
        let request = MockCommentRequest()
        
        let expectation = XCTestExpectation(description: "APIManager throws error")
        do {
            let _: [Comment] = try await apiManager!.fetch(request: request)
            XCTFail("Expected APIManager should throw error while getting comments")
        }
        catch RequestError.noData {
            expectation.fulfill()
        }
    }
}

// MARK: - Mocks

fileprivate class MockAPIRequestHandler: RequestHandling {
    private let shouldSucceed: Bool
    
    init(shouldSucceed: Bool) {
        self.shouldSucceed = shouldSucceed
    }
    
    func fetchData(from request: Request) async throws -> Data {
        if shouldSucceed {
            try Bundle.main.fileData(forResource: "comments")
        } else {
            throw RequestError.noData
        }
    }
}

fileprivate class MockAPIResponseHandler: ResponseHandling {
    private let shouldSucceed: Bool
    
    init(shouldSucceed: Bool) {
        self.shouldSucceed = shouldSucceed
    }
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        if shouldSucceed {
            try JSONDecoder().decode(T.self, from: data)
        } else {
            throw RequestError.decode(description: "No data")
        }
    }
}

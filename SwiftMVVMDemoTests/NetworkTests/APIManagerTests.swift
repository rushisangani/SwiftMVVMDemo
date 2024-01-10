//
//  APIManagerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIManagerTests: XCTestCase {
    var apiManager: APIService?
    
    override func setUpWithError() throws {
        apiManager = APIManager(
            requestHandler: MockAPIRequestHandler(),
            responseHandler: MockAPIResponseHandler()
        )
    }

    override func tearDownWithError() throws {
        apiManager = nil
    }
    
    func testAPIManagerGetComments() async throws {
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
}

// MARK: - Mocks

fileprivate class MockAPIRequestHandler: RequestHandling {
    
    func fetchData(from request: Request) async throws -> Data {
        try Bundle.main.fileData(forResource: "comments")
    }
}

fileprivate class MockAPIResponseHandler: ResponseHandling {
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

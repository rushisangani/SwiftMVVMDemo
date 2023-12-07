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
    
    func testAPIServiceGetComments() async throws {
        var comments: [Comment] = []
        let expectation = XCTestExpectation(description: "APIManager Get Comments")
        
        do {
            comments = try await apiManager!.fetch(request: MockRequest.getComments)
            expectation.fulfill()
            
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
        let filePath = Bundle.jsonFilePath(forResource: "comments")
        return try Data(contentsOf: URL(filePath: filePath))
    }
}

fileprivate class MockAPIResponseHandler: ResponseHandling {
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

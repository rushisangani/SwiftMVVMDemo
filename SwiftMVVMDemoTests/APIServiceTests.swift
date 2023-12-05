//
//  APIServiceTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest
@testable import SwiftMVVMDemo

final class APIServiceTests: XCTestCase {
    var apiService: APIServiceHandler?
    
    override func setUpWithError() throws {
        apiService = APIService(
            requestHandler: MockAPIRequestHandler(),
            responseHandler: MockAPIResponseHandler()
        )
    }

    override func tearDownWithError() throws {
        apiService = nil
    }
    
    func testAPIServiceGetComments() async throws {
        var comments: [Comment] = []
        let expectation = XCTestExpectation(description: "APIService Get Comments")
        
        do {
            comments = try await apiService!.fetch(request: MockRequest.getComments)
            expectation.fulfill()
            
            let comment = try XCTUnwrap(comments.first)
            XCTAssert(comment.id == 1)
            XCTAssert(comment.name == "id labore ex et quam laborum")
            XCTAssert(comment.email == "Eliseo@gardner.biz")
        } 
        catch {
            XCTFail(error.localizedDescription)
        }
    }
}

// MARK: - Mocks

class MockAPIRequestHandler: RequestHandler {
    var session: URLSession = .shared
    
    func fetchData(from request: Request) async throws -> Data {
        let filePath = Bundle.jsonFilePath(forResource: "comments")
        return try Data(contentsOf: URL(filePath: filePath))
    }
}

class MockAPIResponseHandler: ResponseHandler {
    var decoder = JSONDecoder()
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        // TODO: how to return mock data here?
        try decoder.decode(T.self, from: data)
    }
}

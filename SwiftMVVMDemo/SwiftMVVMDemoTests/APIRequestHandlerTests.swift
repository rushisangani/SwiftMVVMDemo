//
//  APIRequestHandlerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest

final class APIRequestHandlerTests: XCTestCase {

    var requestHandler: RequestHandler!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        requestHandler = nil
    }

    func testAPIRequestHandlerReturnsDataWithValidRequest() async throws {
        // mock request
        let request: Request = MockCommentsRequest()
        requestHandler = APIRequestHandler()
        
        do {
            let data = try await requestHandler.fetchData(from: request)
            XCTAssert(!data.isEmpty, "Expected data should not be empty.")
        } 
        catch {
            XCTAssertThrowsError("fatal error")
        }
    }
    
    func testAPIRequestHandlerShouldThrowErrorWithInvalidRequest() async throws {
        // dummy request
        let request = DummyMockRequest()
        requestHandler = APIRequestHandler()
        
        var result: Data?
        result = try? await requestHandler.fetchData(from: request)
        XCTAssertNil(result, "Dummy request should return nil data.")
    }
}

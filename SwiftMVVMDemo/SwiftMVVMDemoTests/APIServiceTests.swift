//
//  NetworkManagerTests.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import XCTest

final class NetworkManagerTests: XCTestCase {

//    var apiService: APIServiceHandler!
//    var mockRequestHandler = MockAPIRequestHandler(session: URLSession.shared)
//    var mockResponseHandler = MockAPIResponseHandler(decoder: JSONDecoder())
//    var mockData = MockData()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        //apiService = nil
    }
    
//    func testAPIServiceRequestSuccess() async throws {
//        apiService = APIService(requestHandler: mockRequestHandler, responseHandler: mockResponseHandler)
//        
//        let result = try await apiService.fetch(request: mock, for: <#T##(Decodable & Encodable).Protocol#>)
//    }
}

//class MockAPIRequestHandler: RequestHandler {
//    var session: URLSession = .shared
//    
//    func fetchData(from request: URLRequest) async throws -> Data {
//        
//    }
//}
//
//class MockAPIResponseHandler: ResponseHandler {
//    var decoder: JSONDecoder
//    
//    init(decoder: JSONDecoder) {
//        self.decoder = decoder
//    }
//    
//    func getResponse<T: Codable>(from data: Data, type: T.Type) throws -> T {
//        return try decoder.decode(T.self, from: data)
//    }
//}

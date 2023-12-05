//
//  MockAPIRequestHandler.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

class MockAPIRequestHandler: RequestHandler {
    var session: URLSession = .shared
    
    func fetchData(from request: Request) async throws -> Data {
        return try Data(contentsOf: URL(filePath: request.path))
    }
}

//
//  MockAPIResponseHandler.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

class MockAPIResponseHandler: ResponseHandler {
    var decoder = JSONDecoder()
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        // TODO: how to return mock data here?
        try decoder.decode(T.self, from: data)
    }
}

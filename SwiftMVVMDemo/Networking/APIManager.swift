//
//  APIManager.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

// MARK: - APIService

protocol APIService {
    func fetch<T: Codable>(request: Request) async throws -> T
}

// MARK: - APIManager

class APIManager: APIService {
    var requestHandler: RequestHandling
    var responseHandler: ResponseHandling
    
    init(requestHandler: RequestHandling = APIRequestHandler(),
         responseHandler: ResponseHandling = APIResponseHandler()
    ) {
        self.requestHandler = requestHandler
        self.responseHandler = responseHandler
    }
    
    func fetch<T: Codable>(request: Request) async throws -> T {
        let data = try await requestHandler.fetchData(from: request)
        return try responseHandler.getResponse(from: data)
    }
}

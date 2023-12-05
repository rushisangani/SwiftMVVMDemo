//
//  APIService.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

protocol APIServiceHandler {
    var requestHandler: RequestHandler { get }
    var responseHandler: ResponseHandler { get }
    func fetch<T: Codable>(request: Request) async throws -> T
}

struct APIService: APIServiceHandler {
    var requestHandler: RequestHandler
    var responseHandler: ResponseHandler
    
    init(requestHandler: RequestHandler = APIRequestHandler(),
         responseHandler: ResponseHandler = APIResponseHandler()
    ) {
        self.requestHandler = requestHandler
        self.responseHandler = responseHandler
    }
    
    func fetch<T: Codable>(request: Request) async throws -> T {
        let data = try await requestHandler.fetchData(from: request)
        return try responseHandler.getResponse(from: data)
    }
}

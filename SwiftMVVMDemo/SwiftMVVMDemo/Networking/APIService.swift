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

class APIService: APIServiceHandler {
    var requestHandler: RequestHandler = APIRequestHandler()
    var responseHandler: ResponseHandler = APIResponseHandler()
    
    func fetch<T: Codable>(request: Request) async throws -> T {
        let data = try await requestHandler.fetchData(from: request)
        return try responseHandler.getResponse(from: data)
    }
}

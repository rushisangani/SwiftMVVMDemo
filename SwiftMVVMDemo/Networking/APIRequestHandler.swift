//
//  APIRequestHandler.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

// MARK: - RequestHandling

protocol RequestHandling {
    func fetchData(from request: Request) async throws -> Data
}

// MARK: - APIRequestHandler

struct APIRequestHandler: RequestHandling {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(from request: Request) async throws -> Data {
        let urlRequest = try request.createURLRequest()
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.failed(description: "Request Failed.")
        }
        switch response.statusCode {
        case 200...299:
            return data
        case 401:
            throw RequestError.unAuthorized
        default:
            throw RequestError.unexpectedStatusCode(description: "Status Code: \(response.statusCode)")
        }
    }
}

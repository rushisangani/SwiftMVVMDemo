//
//  APIResponseHandler.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

// MARK: - ResponseHandling

protocol ResponseHandling {
    func getResponse<T: Codable>(from response: Data) throws -> T
}

// MARK: - APIResponseHandler

struct APIResponseHandler: ResponseHandling {
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw RequestError.decode(description: error.localizedDescription)
        }
    }
}

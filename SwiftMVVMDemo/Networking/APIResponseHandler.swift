//
//  APIResponseHandler.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

// MARK: - ResponseHandler

protocol ResponseHandler {
    var decoder: JSONDecoder { get }
    func getResponse<T: Codable>(from response: Data) throws -> T
}

// MARK: - APIResponseHandler

struct APIResponseHandler: ResponseHandler {
    var decoder = JSONDecoder()
    
    func getResponse<T: Codable>(from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw RequestError.decode(description: error.localizedDescription)
        }
    }
}

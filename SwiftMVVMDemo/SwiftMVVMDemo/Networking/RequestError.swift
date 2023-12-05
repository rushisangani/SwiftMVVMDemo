//
//  RequestError.swift
//  MVVMDemo
//
//  Created by Rushi Sangani on 30/11/2023.
//

import Foundation

public enum RequestError: Error {
    case invalidURL
    case failed(description: String)
    case noData
    case decode(description: String)
    case unAuthorized
    case unexpectedStatusCode(description: String)
    case unknown
    
    var customDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No Data Found"
        case .failed(let description):
            return "Request Failed: \(description)"
        case .decode(let description):
            return "Decoding Error: \(description)"
        case .unAuthorized:
            return "Session Expired"
        case .unexpectedStatusCode(let description):
            return "Unknown Error: \(description)"
        default:
            return "Unknown Error"
        }
    }
}

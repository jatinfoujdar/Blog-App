//
//  APIService.swift
//  IOS
//
//  Created by jatin foujdar on 22/02/26.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    private let baseURL = "http://localhost:1080"
    
    private init() {}
    
    enum NetworkError: Error, LocalizedError {
        case invalidURL
        case noData
        case decodingError
        case serverError(String)
        case unknown
        
        var errorDescription: String? {
            switch self{
            case .invalidURL: return "Invalid URL"
            case .noData: return "No data"
            case .decodingError: return "Decoding error"
            case .serverError(let msg): return msg
            case .unknown: return "Unknown error"
            }
        }
    }
    
}


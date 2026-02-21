//
//  AuthModels.swift
//  IOS
//

import Foundation

struct SignupRequest: Encodable {
    let name: String
    let email: String
    let password: String
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct AuthResponse: Decodable {
    let token: String?
    let message: String?
    let error: String?
    
    
    enum CodingKeys: String, CodingKey {
        case message, token, error
    }
}

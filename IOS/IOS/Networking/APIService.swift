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
    
    func signup(request: SignupRequest , completion: @escaping(Result<AuthResponse, Error>) -> Void
    ){
        guard let url = URL(string: "\(baseURL)/signup")else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            urlRequest.httpBody = try JSONEncoder().encode(request)
        }catch{
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest){data, res , err in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else{
                completion(.failure(NetworkError.noData))
                return
            }
            
            do{
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                if let errMsg = authResponse.error{
                    completion(.failure(NetworkError.serverError(errMsg)))
                }else{
                    completion(.success(authResponse))
                }
            }catch{
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    
    
    func login(request: LoginRequest, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
            guard let url = URL(string: "\(baseURL)/login") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                urlRequest.httpBody = try JSONEncoder().encode(request)
            } catch {
                completion(.failure(error))
                return
            }
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    if let errorMsg = authResponse.error {
                        completion(.failure(NetworkError.serverError(errorMsg)))
                    } else {
                        completion(.success(authResponse))
                    }
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }.resume()
        }
}


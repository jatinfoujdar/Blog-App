//
//  APIService.swift
//  IOS
//
//  Created by jatin foujdar on 22/02/26.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    private let baseURL = "http://localhost:8080"
    
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
    
    
    func updateProfile(
        profile: Profile,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        // Create URL
        guard let url = URL(string: "\(baseURL)/profile") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Create authorized request automatically
        guard var request = authorizedRequest(url: url) else {
            completion(.failure(NetworkError.serverError("User not logged in")))
            return
        }
        
        request.httpMethod = "PUT"
        
        // Encode profile to JSON
        do {
            request.httpBody = try JSONEncoder().encode(profile)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            if httpResponse.statusCode == 401 {
                SessionManager.shared.logout()
                completion(.failure(NetworkError.serverError("Session expired")))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoded = try JSONDecoder().decode(MessageResponse.self, from: data)
                    completion(.success(decoded.message))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            } else {
                completion(.failure(NetworkError.serverError("Failed to update profile")))
            }
            
        }.resume()
    }
    
    
    
    private func authorizedRequest(url: URL) -> URLRequest? {
        
        guard let token = SessionManager.shared.getToken() else{
            return nil
        }
        var req = URLRequest(url: url)
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return req
    }
    
    
    func fetchProfile(completion: @escaping(Result<Profile, Error>)-> Void ) {
        
        guard let url = URL(string: "\(baseURL)/profile") else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        guard let request = authorizedRequest(url: url) else {
            completion(.failure(NetworkError.serverError("User not logged In")))
            return
        }
        
        URLSession.shared.dataTask(with: request){ data ,res, error in
            
            if let error = error{
                DispatchQueue.main.async{
                    completion(.failure(error))
                }
                return
            }
            guard let httpResponse = res as? HTTPURLResponse else{
                DispatchQueue.main.async{
                    completion(.failure(NetworkError.serverError("Invaild response")))
                }
                return
            }
            guard(200...299).contains(httpResponse.statusCode) else{
                DispatchQueue.main.async{
                    completion(.failure(NetworkError.serverError("status code: \(httpResponse.statusCode)")))
                }
                return
            }
            guard let data = data else{
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            do{
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let profile = try decoder.decode(Profile.self, from: data)
                DispatchQueue.main.async{
                    completion(.success(profile))
                }
            }catch{
                DispatchQueue.main.async{
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }
    
    
    func createPost(request: CreatePostRequest,completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/posts") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        guard var urlRequest = authorizedRequest(url: url) else {
            completion(.failure(NetworkError.serverError("User not logged in")))
            return
        }
        
        urlRequest.httpMethod = "POST"
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknown))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let decoded = try JSONDecoder().decode(MessageResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded.message))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.decodingError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.serverError("Failed to create post")))
                }
            }
            
        }.resume()
    }
}

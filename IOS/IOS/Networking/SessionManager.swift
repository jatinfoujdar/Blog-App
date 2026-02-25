//
//  SessionManager.swift
//  IOS
//
//  Created by jatin foujdar on 25/02/26.
//
import Security
import Foundation

final class SessionManager {
    
    static let shared = SessionManager()
    
    private init(){}
    
    private let key = "jwt_token"
    
    func saveToken(_ token: String){
        
        let data = Data(token.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func getToken() -> String? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        
        SecItemCopyMatching(query as CFDictionary, &item)
        
        guard let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func logout(){
        let query:[String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    var  isLoggedIn: Bool {
        return getToken() != nil
    }
}

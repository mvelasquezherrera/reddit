//
//  AuthToken.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

class AuthToken {
    
    static func saveTokens(fromHeader header: [AnyHashable : Any]?) {
        guard let header = header else { return }
        guard let authToken = header["Authorization"] as? String else { return }
        print("SET TOKEN",authToken)
        Storage.standard.set(authToken, forKey: Key.accessToken.rawValue, andLevel: .keychainNonPersistence)
    }
    
    static func getAccessToken() -> String {
        guard let accessToken =  Storage.standard.string(forKey: Key.accessToken.rawValue, andLevel: .keychainNonPersistence) else  {return ""}
        print("GET TOKEN",accessToken)
        return accessToken
    }
    
    static func getRefreshToken() -> String {
        guard let accessToken =  Storage.standard.string(forKey: Key.refreshToken.rawValue, andLevel: .keychainNonPersistence) else  {return ""}
        print("GET REFRESH TOKEN",accessToken)
        return accessToken
    }
    
    static func getSessionID() -> String {
        guard let sessioniD =  Storage.standard.string(forKey: Key.sessionId.rawValue, andLevel: .keychainNonPersistence) else { return "" }
        print("GET SESSION ID",sessioniD)
        return sessioniD
    }
    
}

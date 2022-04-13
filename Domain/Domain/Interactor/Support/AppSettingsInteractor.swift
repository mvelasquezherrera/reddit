//
//  AppSettingsInteractor.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public protocol AppSettingsInteractorProtocol {
    func set(user:User)
    func getUser()->User?
    func set(token: String)
    func set(username: String)
    func getToken() ->String
    func getUsername() ->String
    func setValue(value: String,forKey key: String)
    func getValue(forKey key:String)-> String
    func removeValue(forKey key: String)
    func setIntValue(value:Int, forKey key: String)
}

public class AppSettingsInteractor: Interactor , AppSettingsInteractorProtocol{
        
    public func set(username: String) {
        (self.repository as! RPStorageRepositoryProtocol).set(username: username)
    }
    
    public func getUsername() -> String {
        let username = (self.repository as! RPStorageRepositoryProtocol).getUsername()
        return username
    }
    
    public func setIntValue(value: Int, forKey key: String) {
        (self.repository as! RPStorageRepositoryProtocol).setIntValue(value: value, forKey: key)
    }
    
    public func removeValue(forKey key: String) {
      (self.repository as! RPStorageRepositoryProtocol).removeValue(forKey: key)
    }
    
    public func getValue(forKey key: String) -> String {
        let keyString = (self.repository as!  RPStorageRepositoryProtocol).getValue(forKey: key)
        return keyString
    }
    
    public func setValue(value: String, forKey key: String) {
        
        (self.repository as! RPStorageRepositoryProtocol).setValue(value: value, key: key)
    }
    
    public func set(user: User) {
        let userString = User.encode(user: user)
        (self.repository as! RPStorageRepositoryProtocol).set(user: userString)
    }
    
    public func set(token: String) {
        (self.repository as! RPStorageRepositoryProtocol).set(accessToken: token)
    }
    
    public func getUser() -> User? {
        let userString = (self.repository as! RPStorageRepositoryProtocol).getUser()
        return User.decode(jsonUser: userString)
    }
    
    public func getToken() -> String {
        let token = (self.repository as! RPStorageRepositoryProtocol).getToken()
        return token
    }
}

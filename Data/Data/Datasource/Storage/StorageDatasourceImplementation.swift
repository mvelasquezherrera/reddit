//
//  StorageDatasourceImplementation.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

internal class StorageDataSourceImplementation:StorageDatasource {
    
    func setIntValue(value:Int, forKey key: String){
        Storage.standard.set(value, forKey: key, andLevel: .keychainNonPersistence)
    }
    
    func setValue(value: String,forKey key: String) {
        Storage.standard.set(value, forKey: key, andLevel: .keychainNonPersistence)
    }
    
    func getValue(forKey key:String) -> String {
        guard let value =
            Storage.standard.string(forKey: key, andLevel: .keychainNonPersistence) else{return ""}
        return value
    }
    
    func removeValue(forKey key: String) {
        Storage.standard.delete(forKey: key, andLevel: .keychainNonPersistence)
    }
    
    func set(username: String) {
        Storage.standard.set(username, forKey: "username", andLevel: .keychainNonPersistence)
    }
    
    func getUsername() -> String {
        guard let value = Storage.standard.string(forKey: "username", andLevel: .keychainNonPersistence) else{return ""}
        return value
    }
    
    func set(accessToken: String) {
        Storage.standard.set(accessToken, forKey: "accessToken", andLevel: .keychainNonPersistence)
    }
    
    func getToken() -> String {
        guard let token = Storage.standard.string(forKey: "accessToken", andLevel: .keychainNonPersistence) else { return "" }
        return token
    }
    
    func set(user: String) {
        Storage.standard.set(user, forKey: "user", andLevel: .keychainNonPersistence)
    }
    
    func getUser()->String {
        guard let user = Storage.standard.string(forKey: "user", andLevel: .keychainNonPersistence) else { return "" }
        return user
    }
    
    func setIsOnbordingShowed(isShowed: Bool){
        Storage.standard.set(isShowed, forKey: "isShowedOnboarding", andLevel: .userDefaultsPersistence)
    }
    func getOnboardingIsShowed() -> Bool {
        guard let isShowed =  Storage.standard.bool(forKey: "isShowedOnboarding", andLevel: .userDefaultsPersistence) else { return false}
        return isShowed
        
    }
    
}

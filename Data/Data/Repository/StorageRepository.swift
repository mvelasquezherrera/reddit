//
//  StorageRepository.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation
import Domain

public class StorageRepository: StorageRepositoryProtocol {
    
    private let dataSource: StorageDatasource
    
    public init() {
        self.dataSource = StorageDataSourceImplementation()
    }
    
    public func set(accessToken: String) {
        dataSource.set(accessToken: accessToken)
    }
    
    public func getToken() -> String {
        dataSource.getToken()
    }
    
    public func set(username: String) {
        dataSource.set(username: username)
    }
    
    public func getUsername() -> String {
        dataSource.getUsername()
    }
    
    public func set(user: String) {
        dataSource.set(user: user)
    }
    
    public func getUser() -> String {
        dataSource.getUser()
    }
    
    public func setValue(value: String, key: String) {
        dataSource.setValue(value: value, forKey: key)
    }
    
    public func getValue(forKey key: String) -> String {
        dataSource.getValue(forKey: key)
    }
    
    public func removeValue(forKey key: String) {
        dataSource.removeValue(forKey: key)
    }
    
    public func getOnboardingIsShowed() -> Bool {
        dataSource.getOnboardingIsShowed()
    }
    
    public func setIsOnbording(isShowed: Bool) {
        dataSource.setIsOnbordingShowed(isShowed: isShowed)
    }
    
    public func setIntValue(value: Int, forKey key: String) {
        dataSource.setIntValue(value: value, forKey: key)
    }
    
}

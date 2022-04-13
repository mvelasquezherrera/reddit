//
//  StorageDatasource.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

internal protocol StorageDatasource {
    func set(accessToken: String)
    func set(username: String)
    func getUsername() -> String
    func getToken() -> String
    func removeValue(forKey key: String)
    func set(user: String)
    func getUser() -> String
    func setValue(value: String, forKey key: String)
    func getValue(forKey key: String)-> String
    func setIsOnbordingShowed(isShowed: Bool)
    func getOnboardingIsShowed() -> Bool
    func setIntValue(value:Int, forKey key: String)
}

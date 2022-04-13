//
//  Storage.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

open class Storage {
    public static let standard = Storage()
    
    func set(_ value: NSNumber, forKey key: String, andLevel level: LevelAccesibility) {
        let item = ItemSec(level: level.rawValue, value: value)
        switch level {
        case .userDefaultsPersistence, .userDefaultsNonPersistence: UserDefaultsWrapper.standard.set(item, forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence:
            KeychainWrapper.standard.set(item, forKey: key)
        }
    }
}

//MARK: - PUBLIC SETTERS
extension Storage {
    
    open func set(_ value: Int, forKey key: String, andLevel level: LevelAccesibility) {
        set(NSNumber(value: value), forKey: key, andLevel: level)
    }
    
    open func set(_ value: Float, forKey key: String, andLevel level: LevelAccesibility) {
        set(NSNumber(value: value), forKey: key, andLevel: level)
    }
    
    open func set(_ value: Double, forKey key: String, andLevel level: LevelAccesibility) {
        set(NSNumber(value: value), forKey: key, andLevel: level)
    }
    
    open func set(_ value: Bool, forKey key: String, andLevel level: LevelAccesibility) {
        set(NSNumber(value: value), forKey: key, andLevel: level)
    }
    
    
    open func set(_ value: String, forKey key: String, andLevel level: LevelAccesibility) {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence :
            let item = ItemSec(level: level.rawValue, value: NSString(string: value))
            UserDefaultsWrapper.standard.set(item, forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence :
            let item = ItemSec(level: level.rawValue, value: NSString(string: value))
            KeychainWrapper.standard.set(item, forKey: key)
        }
    }
    
}
//MARK: - PUBLIC GETTERS
extension Storage {
    
    open func bool(forKey key: String, andLevel level: LevelAccesibility) -> Bool? {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence:
            return UserDefaultsWrapper.standard.bool(forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence:
             return KeychainWrapper.standard.bool(forKey: key, andLevel: level)
        }
       
    }
    
    open func integer(forKey key: String, andLevel level: LevelAccesibility) -> Int? {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence:
             return UserDefaultsWrapper.standard.integer(forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence:
             return KeychainWrapper.standard.integer(forKey: key, andLevel: level)
        }
    }
    
    open func float(forKey key: String, andLevel level: LevelAccesibility) -> Float? {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence:
            return UserDefaultsWrapper.standard.float(forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence:
            return KeychainWrapper.standard.float(forKey: key, andLevel: level)
        }
        
    }
    
    open func double(forKey key: String, andLevel level: LevelAccesibility) -> Double? {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence:
             return UserDefaultsWrapper.standard.double(forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence:
            return KeychainWrapper.standard.double(forKey: key, andLevel: level)
        }
        
    }
    
    open func string(forKey key: String, andLevel level: LevelAccesibility) -> String? {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence:
            return UserDefaultsWrapper.standard.string(forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence:
            return KeychainWrapper.standard.string(forKey: key, andLevel: level)
        }
    }
    
}

//MARK: - RESET DELETE
extension Storage {
    
    open func delete(forKey key: String,andLevel level: LevelAccesibility) {
        switch level {
        case .userDefaultsPersistence,.userDefaultsNonPersistence:
             UserDefaultsWrapper.standard.delete(forKey: key, andLevel: level)
        case .keychainNonPersistence , .keychainPersistence :
             KeychainWrapper.standard.delete(key: key, fromLevel: level)
        }
    }
    
    open func reset(level: LevelAccesibility) {
        
        switch level {
        case .userDefaultsPersistence ,.userDefaultsNonPersistence:
             UserDefaultsWrapper.standard.reset(fromLevel: level)
        case .keychainNonPersistence , .keychainPersistence :
            KeychainWrapper.standard.reset(fromLevel: level)
        }
    }
    
}

//
//  KeychainWrapper.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

private let SecMatchLimit: String! = kSecMatchLimit as String
private let SecReturnData: String! = kSecReturnData as String
private let SecReturnPersistentRef: String! = kSecReturnPersistentRef as String
private let SecValueData: String! = kSecValueData as String
private let SecAttrAccessible: String! = kSecAttrAccessible as String
private let SecClass: String! = kSecClass as String
private let SecAttrService: String! = kSecAttrService as String
private let SecAttrGeneric: String! = kSecAttrGeneric as String
private let SecAttrAccount: String! = kSecAttrAccount as String
private let SecAttrAccessGroup: String! = kSecAttrAccessGroup as String
private let SecReturnAttributes: String = kSecReturnAttributes as String

class KeychainWrapper {
    
    public static let defaultKeychainWrapper = KeychainWrapper.standard
    public static let standard = KeychainWrapper()

    private (set) public var serviceName: String
    private (set) public var accessGroup: String?
    private  var  accessibility: KeychainAccesibility = .whenUnlockedThisDeviceOnly


    private static let defaultServiceName: String = {
        return Bundle.main.bundleIdentifier ?? "PichinchaKeychainWrapper"
    }()
    
    private convenience init() {
        self.init(serviceName: KeychainWrapper.defaultServiceName)

    }
    
    public init(serviceName: String, accessGroup: String? = nil) {
        self.serviceName = serviceName
        self.accessGroup = accessGroup
    }
    
    private func update(_ value: Data, forKey key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool {
        var keychainQueryDictionary: [String:Any] = setupKeychainQueryDictionary(forKey: key, withAccessibility: accessibility)
        let updateDictionary = [SecValueData:value]

        if let accessibility = accessibility {
            keychainQueryDictionary[SecAttrAccessible] = accessibility.keychainAttrValue
        } else{
            keychainQueryDictionary[SecAttrAccessible] = self.accessibility.keychainAttrValue
        }
        let status: OSStatus = SecItemUpdate(keychainQueryDictionary as CFDictionary, updateDictionary as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    private func setupKeychainQueryDictionary(forKey key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> [String:Any] {

        var keychainQueryDictionary: [String:Any] = [SecClass:kSecClassGenericPassword]
        keychainQueryDictionary[SecAttrService] = serviceName
        if let accessibility = accessibility {
            keychainQueryDictionary[SecAttrAccessible] = accessibility.keychainAttrValue
        } else {
             keychainQueryDictionary[SecAttrAccessible] = self.accessibility.keychainAttrValue
        }
        if let accessGroup = self.accessGroup {
            keychainQueryDictionary[SecAttrAccessGroup] = accessGroup
        }
        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)
        keychainQueryDictionary[SecAttrGeneric] = encodedIdentifier
        keychainQueryDictionary[SecAttrAccount] = encodedIdentifier
        return keychainQueryDictionary
    }
}


//MARK:GETTERS

extension KeychainWrapper {
    
    func integer(forKey key: String,andLevel level:LevelAccesibility, withAccessibility accessibility: KeychainAccesibility? = nil) -> Int? {
        guard let numberValue = object(forKey: key, andLevel: level) as? NSNumber else {
            return nil
        }
        
        return numberValue.intValue
    }
    
    func float(forKey key: String,andLevel level:LevelAccesibility, withAccessibility accessibility: KeychainAccesibility? = nil) -> Float? {
        guard let numberValue = object(forKey: key, andLevel: level) as? NSNumber else {
            return nil
        }
        return numberValue.floatValue
    }
    
    func double(forKey key: String,andLevel level:LevelAccesibility, withAccessibility accessibility: KeychainAccesibility? = nil) -> Double? {
        guard let numberValue = object(forKey: key, andLevel: level) as? NSNumber else {
            return nil
        }
        return numberValue.doubleValue
    }
    
    func bool(forKey key: String,andLevel level:LevelAccesibility,withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool? {
        guard let numberValue = object(forKey: key, andLevel: level) as? NSNumber else {
            return nil
        }
        return numberValue.boolValue
    }
    
    func string(forKey key: String,andLevel level:LevelAccesibility, withAccessibility accessibility: KeychainAccesibility? = nil) -> String? {
        guard let keychainData = data(forKey: key, withAccessibility: accessibility) else {
            return nil
        }
        guard let dataCoding = NSKeyedUnarchiver.unarchiveObject(with: keychainData) as? ItemSec , dataCoding.level == level.rawValue ,let value = dataCoding.value as? String else{
            return nil
        }
        return value
    }
    
    func object(forKey key: String,andLevel level:LevelAccesibility, withAccessibility accessibility: KeychainAccesibility? = nil) -> NSCoding? {
        guard let keychainData = data(forKey: key, withAccessibility: accessibility) else {
            return nil
        }
        guard let dataCoding = NSKeyedUnarchiver.unarchiveObject(with: keychainData) as? ItemSec , dataCoding.level == level.rawValue else {
            return nil
        }
        return dataCoding.value
    }
    
    func data(forKey key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> Data? {
        var keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key, withAccessibility: accessibility)
        
        keychainQueryDictionary[SecMatchLimit] = kSecMatchLimitOne
        
        keychainQueryDictionary[SecReturnData] = kCFBooleanTrue
        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQueryDictionary as CFDictionary, &result)
        
        return status == noErr ? result as? Data : nil
    }
    
}


//MARK:SETTERS

extension KeychainWrapper {
    
    @discardableResult func set(_ value: NSCoding, forKey key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        return set(data, forKey: key, withAccessibility: accessibility)
    }
    
    @discardableResult func set(_ value: Data, forKey key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool {
        var keychainQueryDictionary: [String:Any] = setupKeychainQueryDictionary(forKey: key, withAccessibility: accessibility)
        
        keychainQueryDictionary[SecValueData] = value
        
        if let accessibility = accessibility {
            keychainQueryDictionary[SecAttrAccessible] = accessibility.keychainAttrValue
        } else {
            keychainQueryDictionary[SecAttrAccessible] = self.accessibility.keychainAttrValue
        }
        
        let status: OSStatus = SecItemAdd(keychainQueryDictionary as CFDictionary, nil)
        
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return update(value, forKey: key, withAccessibility: accessibility)
        } else {
            return false
        }
    }
}

//MARK: RESET

extension KeychainWrapper {
    
    func reset(fromLevel level:LevelAccesibility)  {
        var keychainQueryDictionary: [String:Any] = [
            SecClass: kSecClassGenericPassword,
            SecAttrService: serviceName,
            SecReturnAttributes: kCFBooleanTrue!,
            SecMatchLimit: kSecMatchLimitAll,
        ]
        if let accessGroup = self.accessGroup {
            keychainQueryDictionary[SecAttrAccessGroup] = accessGroup
        }
        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQueryDictionary as CFDictionary, &result)
        guard status == errSecSuccess else {return}
        
        if let results = result as? [[AnyHashable: Any]] {
            for attributes in results {
                if let accountData = attributes[SecAttrAccount] as? Data,
                    let key = String(data: accountData, encoding: String.Encoding.utf8) {
                    if object(forKey: key, andLevel: level) != nil{
                        remove(key: key)
                    }
                } else if let accountData = attributes[kSecAttrAccount] as? Data,
                    let key = String(data: accountData, encoding: String.Encoding.utf8) {
                    if object(forKey: key, andLevel: level) != nil{
                        remove(key: key)
                    }
                }
            }
        }
    }
    
    
    @discardableResult func remove(key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool {
        return removeObject(forKey: key, withAccessibility: accessibility)
    }
    
    
    @discardableResult func delete(key: String,fromLevel level:LevelAccesibility, withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool {
        guard object(forKey: key, andLevel: level) != nil else{
            return false
        }
        return removeObject(forKey: key, withAccessibility: accessibility)
    }
    
    @discardableResult func removeObject(forKey key: String, withAccessibility accessibility: KeychainAccesibility? = nil) -> Bool {
        let keychainQueryDictionary: [String:Any] = setupKeychainQueryDictionary(forKey: key, withAccessibility: accessibility)
        
        let status: OSStatus = SecItemDelete(keychainQueryDictionary as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func removeAllKeys() -> Bool {
        var keychainQueryDictionary: [String:Any] = [SecClass:kSecClassGenericPassword]
        keychainQueryDictionary[SecAttrService] = serviceName
        if let accessGroup = self.accessGroup {
            keychainQueryDictionary[SecAttrAccessGroup] = accessGroup
        }
        
        let status: OSStatus = SecItemDelete(keychainQueryDictionary as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
}

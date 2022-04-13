//
//  UserDefaultsWrapper.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

class UserDefaultsWrapper {
    public static let standard = UserDefaultsWrapper()
    private init() {}

}

//MARK: SETTERS

extension UserDefaultsWrapper {
    
    func set(_ value:NSCoding, forKey key:String,andLevel level:LevelAccesibility){
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.setValue(data, forKey: key)
    }
}

//MARK: RESET

extension UserDefaultsWrapper {
 
    func delete(forKey key: String,andLevel level:LevelAccesibility){
        guard let data = UserDefaults.standard.data(forKey: key),let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec ,item.level == level.rawValue  else{
            return
        }
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func reset(fromLevel level:LevelAccesibility) {
        let matches = UserDefaults.standard.dictionaryRepresentation().filter {
            guard let data = $0.value as? Data,let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec else {
                return false
            }
            return item.level == level.rawValue
        }
        for (key,_) in matches {
            delete(forKey: key, andLevel: level)
        }
    }
    
}

//MARK: GETTERS

extension UserDefaultsWrapper {
    
    func integer(forKey key: String, andLevel level: LevelAccesibility) -> Int? {
        guard let data = UserDefaults.standard.data(forKey: key), let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec, item.level == level.rawValue, let value = item.value as? NSNumber else {
            return nil
        }
        return value.intValue
    }
    
    func bool(forKey key: String, andLevel level: LevelAccesibility) -> Bool? {
        guard let data = UserDefaults.standard.data(forKey: key), let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec, item.level == level.rawValue, let value = item.value as? NSNumber else {
            return nil
        }
        return value.boolValue
    }
    
    func float(forKey key: String, andLevel level: LevelAccesibility) -> Float? {
        guard let data = UserDefaults.standard.data(forKey: key),let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec,item.level == level.rawValue ,let value = item.value as? NSNumber else{
            return nil
        }
        return value.floatValue
    }
    
    func double(forKey key: String, andLevel level: LevelAccesibility) -> Double? {
        guard let data = UserDefaults.standard.data(forKey: key), let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec, item.level == level.rawValue, let value = item.value as? NSNumber else {
            return nil
        }
        return value.doubleValue
    }
    
    func string(forKey key: String, andLevel level: LevelAccesibility) -> String? {
        guard let data = UserDefaults.standard.data(forKey: key), let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? ItemSec, item.level == level.rawValue, let value = item.value as? String else {
            return nil
        }
        return value
     }
    
}

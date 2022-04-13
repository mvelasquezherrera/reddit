//
//  ItemSec.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

class ItemSec: NSObject, NSCoding {
    
    var level: Int
    var value: NSCoding
    
    enum Key: String {
        case level = "level"
        case value = "value"
    }
    
    init(level: Int, value: NSCoding) {
        self.level = level
        self.value = value
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(level, forKey: Key.level.rawValue)
        aCoder.encode(value, forKey: Key.value.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.level = aDecoder.decodeInteger(forKey: Key.level.rawValue)
        self.value = aDecoder.decodeObject(forKey: Key.value.rawValue) as! NSCoding
    }
    
}

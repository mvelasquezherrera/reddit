//
//  LevelAccesibility.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public enum LevelAccesibility: Int {
    case userDefaultsPersistence = 0
    case userDefaultsNonPersistence = 1
    case keychainNonPersistence = 2
    case keychainPersistence = 3
}

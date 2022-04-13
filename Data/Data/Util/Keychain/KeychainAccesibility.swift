//
//  KeychainAccesibility.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

protocol KeychainAttrRepresentable {
    var keychainAttrValue: CFString { get }
}

// MARK: - KeychainItemAccessibility
public enum KeychainAccesibility {

    case afterFirstUnlock
    case afterFirstUnlockThisDeviceOnly
    case always
    case whenPasscodeSetThisDeviceOnly
    case alwaysThisDeviceOnly
    case whenUnlocked
    case whenUnlockedThisDeviceOnly
    
    static func accessibilityForAttributeValue(_ keychainAttrValue: CFString) -> KeychainAccesibility? {
        for (key, value) in keychainItemAccessibilityLookup {
            if value == keychainAttrValue {
                return key
            }
        }
        return nil
    }
}

private let keychainItemAccessibilityLookup: [KeychainAccesibility:CFString] = {
    var lookup: [KeychainAccesibility:CFString] = [
        .afterFirstUnlock: kSecAttrAccessibleAfterFirstUnlock,
        .afterFirstUnlockThisDeviceOnly: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
        .always: kSecAttrAccessibleAlways,
        .whenPasscodeSetThisDeviceOnly: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
        .alwaysThisDeviceOnly : kSecAttrAccessibleAlwaysThisDeviceOnly,
        .whenUnlocked: kSecAttrAccessibleWhenUnlocked,
        .whenUnlockedThisDeviceOnly: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]
    
    return lookup
}()

extension KeychainAccesibility : KeychainAttrRepresentable {
    internal var keychainAttrValue: CFString {
        return keychainItemAccessibilityLookup[self]!
    }
}

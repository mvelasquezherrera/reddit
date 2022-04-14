//
//  Configuration.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public let AppEnvironment: Environment = {
    
    let environment = Environment(rawValue: Bundle.main.bundleIdentifier ?? "")
    switch environment {
    case .Development:
        return Environment.Development
    case .UAT:
        return Environment.UAT
    case .Production:
        return Environment.Production
    default:
        fatalError("Environment don't exist")
    }
    
}()

public protocol Configuration {
    static var serverBaseUrl: String { get }
    static var serverUrl: String { get }
    static var apikey: String { get }
    static var key: String { get }
    static var pathGoogleService: String { get set }
}

struct ProductionConfig: Configuration {
    
    static let serverBaseUrl = "https://www.reddit.com/r/chile/"
    static let serverUrl = "https://www.reddit.com/r/chile/"
    static let apikey = ""
    static let key = ""
    static var pathGoogleService = ""
    
}

struct UATConfig: Configuration {
    
    static let serverBaseUrl = "https://www.reddit.com/r/chile/"
    static let serverUrl = "https://www.reddit.com/r/chile/"
    static let apikey = ""
    static let key = ""
    static var pathGoogleService = ""
    
}

struct DevelopConfig: Configuration {
    
    static let serverBaseUrl = "https://www.reddit.com/r/chile/"
    static let serverUrl = "https://www.reddit.com/r/chile/"
    static let apikey = ""
    static let key = ""
    static var pathGoogleService = ""
    
}

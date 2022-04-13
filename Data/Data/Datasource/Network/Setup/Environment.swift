//
//  Environment.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public enum Environment: String {
    case Development = "com.mvelasquezherrera.Reddit.dev"
    case UAT = "com.mvelasquezherrera.Reddit.uat"
    case Production = "com.mvelasquezherrera.Reddit"
}

public extension Environment {
    var configuration: Configuration.Type {
        switch self {
        case .Development:
            return DevelopConfig.self
        case .UAT:
            return UATConfig.self
        case .Production:
            return ProductionConfig.self
        }
    }
}

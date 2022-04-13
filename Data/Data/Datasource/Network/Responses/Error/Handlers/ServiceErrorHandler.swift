//
//  ServiceErrorHandler.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

enum ServiceErrorType: String {
    case unknownError
    case databaseTimeoutError      = "1"
    case entityMappingError        = "-2"
    case internalError             = "-3"
    case databaseAvailabilityError = "-4"
    case networkError              = "-5"
    case unauthorized
    case forbidden
    case custom
}


class ServiceErrorHandler {
    
    static func get(code:String?,description:String?) -> Error {
        guard let code = code else {
            return ServiceError(type: .unknownError, reason: NSLocalizedString("defaultError", comment: "defaultError"))
        }
        return ServiceError(type: ServiceErrorType(rawValue: code) ?? ServiceErrorType.custom, reason: description ?? NSLocalizedString("defaultError", comment: "defaultError"))
    }
    
    static func getNetworkError()-> Error {
        return ServiceError(type: .networkError, reason: NSLocalizedString("networkConnectionError", comment: "networkConnectionError"))
    }
    
    static func validateSessionError(from status:Int?,code:String?,description:String?)-> Error {
        switch status {
        case 401:  return ServiceError(type: .unauthorized, reason:description ?? NSLocalizedString("defaultError", comment: "defaultError"))
        case 403:  return ServiceError(type: .forbidden, reason:description ?? NSLocalizedString("defaultError", comment: "defaultError"))
        default:
            return get(code: code, description: description)
        }
    }
    
}

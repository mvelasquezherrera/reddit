//
//  ServiceError.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation
import Domain

struct ServiceError: Error {
    var type: ServiceErrorType
    var reason: String
}

extension ServiceError {
    
    static func get(_ error: Error) -> ErrorResponse {
        guard let serviceError = error as? ServiceError else {
            return ErrorResponse(type: .unknown, description: NSLocalizedString("defaultError", comment: "defaultError"))
        }
        return ErrorResponse(type: ResponseType(rawValue: serviceError.type.rawValue), description: serviceError.reason)
    }
    
}

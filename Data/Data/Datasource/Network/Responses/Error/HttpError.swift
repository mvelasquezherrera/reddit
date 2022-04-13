//
//  HttpError.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation
import Domain

struct HttpError: Error {
    var type: HttpErrorType
    var reason: String
}

extension HttpError {
    
    static func get(_ error: Error) -> ErrorResponse {
        guard let httpError = error as? HttpError else {
            return ErrorResponse(type: .unknown, description: "Parsing Error")
        }
        return ErrorResponse(type: ResponseType(rawValue: httpError.type.rawValue) , description: httpError.reason)
    }
    
}

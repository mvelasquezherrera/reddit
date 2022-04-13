//
//  ServiceReponseHandler.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

enum ServiceReponseCode: String {
    case success = "JA0000"
    case success1 = "000000"
    case databaseTimeoutError = "-1"
    case entityMappingError = "-2"
    case internalError = "-3"
    case databaseAvailabilityError = "-4"
}

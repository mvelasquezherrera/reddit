//
//  ErrorReponse.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public class ErrorResponse: Error {
    
    public var type: ResponseType?
    public var description: String?
    
    public init(type: ResponseType?, description: String?) {
        self.type = type
        self.description = description
    }
    
}

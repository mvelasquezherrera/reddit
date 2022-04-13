//
//  ServiceDatasource.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation
import Alamofire
import Domain

class ServiceDataSourceImplementation: ServiceDataSource {
    
    private var sessionManager: Session?
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = 180
        configuration.timeoutIntervalForResource = 180
        
        self.sessionManager = Alamofire.Session(configuration: configuration)
    }
    
}

extension Request {
    
    public func debugLog() -> Self {
        
        if AppEnvironment != Environment.Production {
            TimberjackHelper.logBody(_newRequest: self.request!)
        }
        
        return self
        
    }
    
}

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
    
    func getListPost(request: RequestObject, completion: @escaping (Result<PostEntity, Error>) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            
            guard let requestRef = request as? ListPostRequestObject else { return }
            
            let baseUrl = AppEnvironment.configuration.serverUrl
            
            sessionManager?.request(baseUrl + requestRef.path, method: request.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                AuthToken.saveTokens(fromHeader: response.response?.allHeaderFields)
                let responseString = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint("LISTADO DE POST RESPONSE: \(responseString!)")
                
                switch response.result {
                case .success(let data):
                    
                    guard let post = try? JSONDecoder().decode(PostEntity.self, from: data) else {
                        return
                    }
                    
                    completion(.success(post))
                        
                case .failure(let error):
                    // Error del servicio
                    
                    guard let data = response.data, let serviceError = try? JSONDecoder().decode(BaseResponseEntity.self, from: data) else {
                        completion(.failure(HttpErrorHandler.get(error)))
                        return
                    }
                    
                    completion(.failure(ServiceErrorHandler.validateSessionError(from: response.response?.statusCode, code: "Custom Error", description: serviceError.message)))
                    
                }
                
            })
            
        } else {
//            completion(.failure(Error(self)))
            // Error de conexión por Wifi o Datos
        }
        
    }
    
    func getFilterListPost(request: RequestObject, completion: @escaping (Result<PostEntity, Error>) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            
            guard let requestRef = request as? FilterListPostRequestObject else { return }
            
            let baseUrl = AppEnvironment.configuration.serverUrl
            
            sessionManager?.request(baseUrl + requestRef.path, method: request.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                AuthToken.saveTokens(fromHeader: response.response?.allHeaderFields)
                let responseString = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint("LISTADO FILTRADO DE POST RESPONSE: \(responseString!)")
                
                switch response.result {
                case .success(let data):
                    
                    guard let post = try? JSONDecoder().decode(PostEntity.self, from: data) else {
                        return
                    }
                    
                    completion(.success(post))
                        
                case .failure(let error):
                    // Error del servicio
                    
                    guard let data = response.data, let serviceError = try? JSONDecoder().decode(BaseResponseEntity.self, from: data) else {
                        completion(.failure(HttpErrorHandler.get(error)))
                        return
                    }
                    
                    completion(.failure(ServiceErrorHandler.validateSessionError(from: response.response?.statusCode, code: "Custom Error", description: serviceError.message)))
                    
                }
                
            })
            
        } else {
//            completion(.failure(Error(self)))
            // Error de conexión por Wifi o Datos
        }
        
    }
    
}

extension Request {
    
    public func debugLog() -> Self {
        
        if AppEnvironment != Environment.Production {
//            TimberjackHelper.logBody(_newRequest: self.request!)
        }
        
        return self
        
    }
    
}

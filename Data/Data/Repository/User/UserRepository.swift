//
//  UserRepository.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation
import Domain

public class UserRepository: UserRepositoryProtocol {
    
    private let dataSource: ServiceDataSource
    
    public init() {
        self.dataSource = ServiceDataSourceImplementation()
    }
    
    public func getListPost(completion: @escaping (Result<PostModel, Error>) -> Void) {
        
        self.dataSource.getListPost(request: ListPostRequestObject()) { result in
            switch result {
            case .success(let data):
                completion(.success(PostEntity.mapperPostEntity(entity: data)))
            case .failure(let error):
                if error is HttpError {
                    completion(.failure(HttpError.get(error)))
                } else {
                    completion(.failure(ServiceError.get(error)))
                }
            }
        }
        
    }
    
    public func getFilterListPost(searchText: String, completion: @escaping (Result<PostModel, Error>) -> Void) {
        
        self.dataSource.getFilterListPost(request: FilterListPostRequestObject(searchText: searchText)) { result in
            switch result {
            case .success(let data):
                completion(.success(PostEntity.mapperPostEntity(entity: data)))
            case .failure(let error):
                if error is HttpError {
                    completion(.failure(HttpError.get(error)))
                } else {
                    completion(.failure(ServiceError.get(error)))
                }
            }
        }
        
    }
    
}

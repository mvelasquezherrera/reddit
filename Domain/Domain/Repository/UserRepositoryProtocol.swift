//
//  UserRepositoryProtocol.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public protocol RepositoryProtocol {
    
}

public protocol UserRepositoryProtocol: RepositoryProtocol {
    func getListPost(completion: @escaping (Result<PostModel, Error>) -> Void)
    func getFilterListPost(searchText: String, completion: @escaping (Result<PostModel, Error>) -> Void)
}

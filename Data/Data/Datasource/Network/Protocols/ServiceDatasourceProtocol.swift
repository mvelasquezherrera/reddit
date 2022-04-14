//
//  ServiceDatasourceProtocol.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation
import Domain

internal protocol ServiceDataSource {
    func getListPost(request: RequestObject, completion: @escaping (Result<PostEntity, Error>) -> Void)
    func getFilterListPost(request: RequestObject, completion: @escaping (Result<PostEntity, Error>) -> Void)
}

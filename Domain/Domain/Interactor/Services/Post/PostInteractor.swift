//
//  PostInteractor.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 14/04/22.
//

import Foundation

public protocol PostInteractorProtocol {
    func getListPost(completion:@escaping (Result<PostModel, Error>) -> Void)
}

public class PostInteractor: Interactor, PostInteractorProtocol {
    
    public func getListPost(completion:@escaping (Result<PostModel, Error>) -> Void) {
        return (self.repository as! UserRepositoryProtocol).getListPost { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

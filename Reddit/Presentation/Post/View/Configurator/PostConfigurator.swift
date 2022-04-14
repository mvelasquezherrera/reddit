//
//  PostConfigurator.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import UIKit
import Domain
import Data

protocol PostConfiguratorProtocol {
    func configure(viewController: PostViewController)
}

class PostConfigurator: PostConfiguratorProtocol {
    
    func configure(viewController: PostViewController) {
        let router = PostRouter(withView: viewController)
        let interactorPost = PostInteractor(repository: UserRepository())
        viewController.presenter = PostPresenter(view: viewController, router: router, interactorSettings: AppSettingsInteractor(repository: StorageRepository()), interactorPost: interactorPost)
    }
    
}

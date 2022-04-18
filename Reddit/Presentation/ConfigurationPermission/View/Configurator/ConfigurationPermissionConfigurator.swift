//
//  ConfigurationPermissionConfigurator.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import UIKit
import Domain
import Data

protocol ConfigurationPermissionConfiguratorProtocol {
    func configure(viewController: ConfigurationPermissionViewController)
}

class ConfigurationPermissionConfigurator: ConfigurationPermissionConfiguratorProtocol {
    
    func configure(viewController: ConfigurationPermissionViewController) {
        let router = ConfigurationPermissionRouter(withView: viewController)
        let interactorConfigurationPermission = ConfigurationPermissionInteractor(repository: UserRepository())
        viewController.presenter = ConfigurationPermissionPresenter(view: viewController, router: router, interactorSettings: AppSettingsInteractor(repository: StorageRepository()))
    }
    
}

//
//  PostRouter.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import UIKit

protocol PostRouterProtocol {
    func routeToPrevious()
    func routeToPopup()
    func routeToConfigurationPermission()
}

class PostRouter {
    
    private let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
    private let storyboardPost = UIStoryboard(name: "Post", bundle: nil)
    private let storyboardCustomViews = UIStoryboard(name: "CustomViews", bundle: nil)
    
    weak var currentViewController: PostViewController?
    init(withView viewController: PostViewController) {
        self.currentViewController = viewController
    }
}

// MARK: - PROTOCOL METHODS
extension PostRouter: PostRouterProtocol {
    
    func routeToPrevious() {
        guard let view = currentViewController else{return}
        view.navigationController?.popViewController(animated: true)
    }

    func routeToPopup() {
        
    }
    
    func routeToConfigurationPermission() {
        guard let controller = storyboardMain.instantiateViewController(withIdentifier: "ConfigurationPermissionViewController") as? ConfigurationPermissionViewController, let view = self.currentViewController else { return }
//        controller.modalPresentationStyle = .fullScreen
//        view.navigationController?.pushViewController(controller, animated: true)
        view.present(controller, animated: true)
    }
    
}

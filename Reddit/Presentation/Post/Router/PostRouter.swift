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
}

class PostRouter {
    
    private let storyboardPost = UIStoryboard(name: "Post", bundle: nil)
    
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
    
    func routeToLoading() {
        guard let loadingView = storyboardPost.instantiateViewController(withIdentifier: "CustomLoadingViewController") as? CustomLoadingViewController else { return }
        loadingView.modalPresentationStyle = .custom
        loadingView.modalTransitionStyle = .crossDissolve
        currentViewController!.present(loadingView, animated: true)
    }
    
    func routeToDismissLoading(completion: @escaping (() -> Void)) {
        guard let view = currentViewController else { return }
        view.dismiss(animated: true, completion: completion)
    }
    
}

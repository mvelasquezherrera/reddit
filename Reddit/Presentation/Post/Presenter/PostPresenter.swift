//
//  PostPresenter.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Domain

protocol PostPresenterProtocol {
    func viewDidLoad()
    func goToPrevious()
}

class PostPresenter {
    
    private weak var view: PostViewControllerProtocol?
    private var router: PostRouterProtocol
    private var viewData: ViewData?
    
    // Interactors
    private var interactorSettings: AppSettingsInteractorProtocol
    
    init(view: PostViewControllerProtocol, router: PostRouterProtocol, interactorSettings: AppSettingsInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactorSettings = interactorSettings
    }
    
}

// MARK: - PROTOCOL METHODS
extension PostPresenter: PostPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func goToPrevious() {
        router.routeToPrevious()
    }
    
    
    
}

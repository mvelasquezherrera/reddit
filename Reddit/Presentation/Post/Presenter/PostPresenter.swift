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
    func getListPost(isPull: Bool)
    func getNumberOfRows() -> Int
    func getDataOfRows(row: Int) -> PostChildrenModel
}

class PostPresenter {
    
    private weak var view: PostViewControllerProtocol?
    private var router: PostRouterProtocol
    private var viewData: ViewData?
    
    var listPost = PostModel(kind: "", data: PostDataModel(after: "", dist: 0, modhash: "", geo_filter: "", children: [PostChildrenModel(kind: "", data: PostDataChildrenModel(url: "", title: "", score: 0, num_comments: 0))], before: ""))
    
    // Interactors
    private var interactorSettings: AppSettingsInteractorProtocol
    private var interactorPost: PostInteractorProtocol
    
    init(view: PostViewControllerProtocol, router: PostRouterProtocol, interactorSettings: AppSettingsInteractorProtocol, interactorPost: PostInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactorSettings = interactorSettings
        self.interactorPost = interactorPost
    }
    
}

// MARK: - PROTOCOL METHODS
extension PostPresenter: PostPresenterProtocol {
    
    func viewDidLoad() {
        getListPost(isPull: false)
    }
    
    func goToPrevious() {
        router.routeToPrevious()
    }
    
    func getListPost(isPull: Bool) {
        
        if !isPull {
            view?.startLoadingAnimation()
        }
        
        interactorPost.getListPost { [weak self] (result) in
            self?.view?.finishLoadingAnimation()
            switch result {
            case .success(let listadoPost):
                
                guard let self = self else { return }
                guard let view = self.view else { return }

                self.listPost = listadoPost
                
                view.reloadData()
                print("Listado Post SUCCESS PRESENTER: \(listadoPost)")
                
            case .failure(let error):
                print("ERROR Listado Post: \(error)")
            }
            
        }
        
    }
    
    func getNumberOfRows() -> Int {
        return listPost.data?.children?.count ?? 0
    }
    
    func getDataOfRows(row: Int) -> PostChildrenModel {
        return listPost.data?.children?[row] ?? PostChildrenModel(kind: "", data: PostDataChildrenModel(url: "", title: "", score: 0, num_comments: 0))
    }
    
}

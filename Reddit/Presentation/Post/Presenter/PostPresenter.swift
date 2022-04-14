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
    func updateSearchResultsTable(searchText: String)
    func actionSearchBarCancelButtonClicked()
}

class PostPresenter {
    
    private weak var view: PostViewControllerProtocol?
    private var router: PostRouterProtocol
    private var viewData: ViewData?
    
    var dataPost = PostModel(kind: "", data: PostDataModel(after: "", dist: 0, modhash: "", geo_filter: "", children: [PostChildrenModel(kind: "", data: PostDataChildrenModel(url: "", title: "", score: 0, num_comments: 0))], before: ""))
    
    private var listPost: [PostChildrenModel] = []
    var searching = false
    var searchListPost = [PostChildrenModel]()
    
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
            case .success(let dataPost):
                
                guard let self = self else { return }
                guard let view = self.view else { return }

                self.dataPost = dataPost
                self.listPost = dataPost.data?.children ?? [PostChildrenModel(kind: "", data: PostDataChildrenModel(url: "", title: "", score: 0, num_comments: 0))]
                
                view.reloadData()
                view.showEmptyView(show: false)
                print("Data Post SUCCESS PRESENTER: \(dataPost)")
                
            case .failure(let error):
                print("ERROR Listado Post: \(error)")
            }
            
        }
        
    }
    
    func getFilterListPost(searchText: String) {
        
        interactorPost.getFilterListPost(searchText: searchText) { [weak self] (result) in
            self?.view?.finishLoadingAnimation()
            switch result {
            case .success(let dataPost):
                
                guard let self = self else { return }
                guard let view = self.view else { return }

                self.dataPost = dataPost
                self.listPost = dataPost.data?.children ?? [PostChildrenModel(kind: "", data: PostDataChildrenModel(url: "", title: "", score: 0, num_comments: 0))]
                
                let childrenData = dataPost.data?.children
                
                if childrenData?.count == 0 {
                    view.showEmptyView(show: true)
                } else {
                    view.showEmptyView(show: false)
                }
                
                view.reloadData()
                print("Data Post Filtrado SUCCESS PRESENTER: \(dataPost)")
                
            case .failure(let error):
                print("ERROR Filtrado Listado Post: \(error)")
            }
            
        }
        
    }
    
    func getNumberOfRows() -> Int {
        return dataPost.data?.children?.count ?? 0
    }
    
    func getDataOfRows(row: Int) -> PostChildrenModel {
        return dataPost.data?.children?[row] ?? PostChildrenModel(kind: "", data: PostDataChildrenModel(url: "", title: "", score: 0, num_comments: 0))
    }
    
    func updateSearchResultsTable(searchText: String) {
        
        if !searchText.isEmpty {
            searching = true
            searchListPost.removeAll()
            
//            for item in listPost {
//
//                guard let titlePost = item.data?.title else { return }
//
//                if titlePost.lowercased().contains(searchText.lowercased()) {
//                    searchListPost.append(item)
//                }
//
//            }
            
            getFilterListPost(searchText: searchText)
            
        } else {
            
            searching = false
            searchListPost.removeAll()
            searchListPost = listPost
            getListPost(isPull: false)
            view?.showEmptyView(show: false)
            
        }
        
    }
    
    func actionSearchBarCancelButtonClicked() {
        searching = false
        searchListPost.removeAll()
        view?.showEmptyView(show: false)
        view?.cleanSearchText()
    }
    
}

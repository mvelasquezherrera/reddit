//
//  ConfigurationPermissionPresenter.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import Domain
import UIKit

protocol ConfigurationPermissionPresenterProtocol {
    func viewDidLoad()
    func goToPrevious()
    func getNumberOfItems() -> Int
    func getDataOfItems(row: Int) -> PermissionModel
    func dismissConfiguration()
    func showAlertPermissionCamera(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void))
    func showAlertPermissionNotifications(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void))
    func showAlertPermissionLocation(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void))
    func openSettingsAppDevice()
}

class ConfigurationPermissionPresenter {
    
    private weak var view: ConfigurationPermissionViewControllerProtocol?
    private var router: ConfigurationPermissionRouterProtocol
    private var viewData: ViewData?
    
    // Interactors
    private var interactorSettings: AppSettingsInteractorProtocol
    
    // Variables
    var listPermission = [PermissionModel]()
    
    init(view: ConfigurationPermissionViewControllerProtocol, router: ConfigurationPermissionRouterProtocol, interactorSettings: AppSettingsInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactorSettings = interactorSettings
    }
    
}

// MARK: - PROTOCOL METHODS
extension ConfigurationPermissionPresenter: ConfigurationPermissionPresenterProtocol {
    
    func viewDidLoad() {
        setPermissions()
    }
    
    func goToPrevious() {
        router.routeToPrevious()
    }
    
    func setPermissions() {
        
        listPermission.removeAll()
        
        let permissionOne = PermissionModel(imgNamePermission: "imgPermissionOne", titlePermission: "Camera Access", descriptionPermission: "Please allow access to your camera to take photos", titleBtnAllow: "Allow", titleBtnCancel: "Cancel")
        let permissionTwo = PermissionModel(imgNamePermission: "imgPermissionTwo", titlePermission: "Enable push notifications", descriptionPermission: "Enable push notifications to let send you personal news and updates.", titleBtnAllow: "Enable", titleBtnCancel: "Cancel")
        let permissionThree = PermissionModel(imgNamePermission: "imgPermissionThree", titlePermission: "Enable location services", descriptionPermission: "We wants to access your location only to provide a better experience by helping you find new friends nearby.", titleBtnAllow: "Enable", titleBtnCancel: "Cancel")
        
        listPermission.append(permissionOne)
        listPermission.append(permissionTwo)
        listPermission.append(permissionThree)
        
        view?.reloadData()
        
    }
    
    func getNumberOfItems() -> Int {
        return listPermission.count
    }
    
    func getDataOfItems(row: Int) -> PermissionModel {
        return listPermission[row]
    }
    
    func dismissConfiguration() {
        router.dismissConfiguration()
    }
    
    func showAlertPermissionCamera(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void)) {
        router.showAlertPermissionCamera(actionConfigure: actionConfigure, actionContinue: actionContinue)
    }
    
    func showAlertPermissionNotifications(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void)) {
        router.showAlertPermissionNotifications(actionConfigure: actionConfigure, actionContinue: actionContinue)
    }
    
    func showAlertPermissionLocation(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void)) {
        router.showAlertPermissionLocation(actionConfigure: actionConfigure, actionContinue: actionContinue)
    }
    
    func openSettingsAppDevice() {
        router.openSettingsAppDevice()
    }
    
}

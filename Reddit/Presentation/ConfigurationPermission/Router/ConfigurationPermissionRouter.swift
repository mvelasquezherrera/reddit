//
//  ConfigurationPermissionRouter.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import UIKit

protocol ConfigurationPermissionRouterProtocol {
    func routeToPrevious()
    func routeToPopup()
    func dismissConfiguration()
    func showAlertPermissionCamera(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void))
    func showAlertPermissionNotifications(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void))
    func showAlertPermissionLocation(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void))
    func openSettingsAppDevice()
}

class ConfigurationPermissionRouter {
    
    private let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
    private let storyboardCustomViews = UIStoryboard(name: "CustomViews", bundle: nil)
    
    weak var currentViewController: ConfigurationPermissionViewController?
    init(withView viewController: ConfigurationPermissionViewController) {
        self.currentViewController = viewController
    }
}

// MARK: - PROTOCOL METHODS
extension ConfigurationPermissionRouter: ConfigurationPermissionRouterProtocol {
    
    func routeToPrevious() {
        guard let view = currentViewController else{return}
        view.navigationController?.popViewController(animated: true)
    }

    func routeToPopup() {
        
    }
    
    func dismissConfiguration() {
        currentViewController?.dismiss(animated: true)
    }
    
    func showAlertPermissionCamera(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void)) {
        
        let alert = UIAlertController(title: "Permiso a la cámara", message: "Usted ya configuró el permiso a la cámara. Si desea activarla o desactivarla, presione en configurar; sino presione en continuar.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Configurar", style: .default, handler: actionConfigure))
        alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: actionContinue))
        
        currentViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertPermissionNotifications(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void)) {
        
        let alert = UIAlertController(title: "Permiso de enviar notificaciones", message: "Usted ya configuró el permiso de enviar notificaciones. Si desea activarla o desactivarla, presione en configurar; sino presione en continuar.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Configurar", style: .default, handler: actionConfigure))
        alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: actionContinue))
        
        currentViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertPermissionLocation(actionConfigure: @escaping ((UIAlertAction) -> Void), actionContinue: @escaping ((UIAlertAction) -> Void)) {
        
        let alert = UIAlertController(title: "Permiso a la ubicación", message: "Usted ya configuró el permiso a la ubicación. Si desea activarla o desactivarla, presione en configurar; sino presione en continuar.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Configurar", style: .default, handler: actionConfigure))
        alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: actionContinue))
        
        currentViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func openSettingsAppDevice() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                
            })
        }
    }
    
}

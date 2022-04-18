//
//  ConfigurationPermissionCollectionViewCell.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import UIKit
import AVFoundation
import CoreLocation

class ConfigurationPermissionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPermission: UIImageView!
    @IBOutlet weak var lblTitlePermission: UILabel!
    @IBOutlet weak var lblDescriptionPermission: UILabel!
    @IBOutlet weak var btnAllow: RoundedCornerButton!
    @IBOutlet weak var btnCancel: RoundedCornerButton!
    
    static let identifier = "ConfigurationPermissionCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "ConfigurationPermissionCollectionViewCell", bundle: nil)
    }
    
    var view: ConfigurationPermissionViewControllerProtocol?
    var presenter: ConfigurationPermissionPresenterProtocol!
    
    var nameImgPermission: String = "" {
        didSet {
            imgPermission.image = UIImage(named: nameImgPermission)
        }
    }
    
    var titlePermission: String = "" {
        didSet {
            lblTitlePermission.text = titlePermission
            lblTitlePermission.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
            lblTitlePermission.textColor = ColorPalette.DesignSystem.titleColor
            lblTitlePermission.numberOfLines = 0
            lblTitlePermission.textAlignment = .center
        }
    }
    
    var descriptionPermission: String = "" {
        didSet {
            lblDescriptionPermission.text = descriptionPermission
            lblDescriptionPermission.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
            lblDescriptionPermission.textColor = ColorPalette.DesignSystem.titleColor
            lblDescriptionPermission.numberOfLines = 0
            lblDescriptionPermission.textAlignment = .center
        }
    }
    
    var titleBtnAllow: String = "" {
        didSet {
            btnAllow.type = .primary
            btnAllow.setTitle(titleBtnAllow, for: .normal)
        }
    }
    
    var titleBtnCancel: String = "" {
        didSet {
            btnCancel.type = .cancel
            btnCancel.setTitle(titleBtnCancel, for: .normal)
        }
    }
    
    var row = 0
    
    var locationManager: CLLocationManager?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

}

// MARK: - SETUP
extension ConfigurationPermissionCollectionViewCell {
    
    func configureUI() {
        
        switch row {
        case 0:
            break
        case 1:
            break
        case 2:
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
        default:
            break
        }
        
    }
    
}

// MARK: - @IBAction
extension ConfigurationPermissionCollectionViewCell {
    
    @IBAction func btnAllowAction(_ sender: Any) {
        
        switch row {
        case 0:
            
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                //Están aceptados
                print("Permiso Cámara: Están aceptados")
                presenter.showAlertPermissionCamera { alertConfigure in
                    self.presenter.openSettingsAppDevice()
                } actionContinue: { alertContinue in
                    self.view?.cancelButtonAction()
                }

            } else {
                
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted :Bool) -> Void in
                    
                    if granted == true {
                        //Los ha aceptado
                        print("Permiso Cámara: Los ha aceptado")
                    } else {
                        //No los ha aceptado
                        print("Permiso Cámara: No los ha aceptado")
                        
                        self.presenter.openSettingsAppDevice()
                        
                    }
                    
                })
                
            }
            
        case 1:
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: .alert) { status, error in
                print("status: \(status)")
                
                DispatchQueue.main.async {
                    self.presenter.showAlertPermissionNotifications { alertConfigure in
                        self.presenter.openSettingsAppDevice()
                    } actionContinue: { alertContinue in
                        self.view?.cancelButtonAction()
                    }
                }
                
            }
            
        case 2:
            
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
            
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            
            switch status {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
                presenter.showAlertPermissionLocation { alertConfigure in
                    self.presenter.openSettingsAppDevice()
                } actionContinue: { alertContinue in
                    self.view?.cancelButtonAction()
                }
            case .denied:
                print("denied")
                presenter.showAlertPermissionLocation { alertConfigure in
                    self.presenter.openSettingsAppDevice()
                } actionContinue: { alertContinue in
                    self.view?.cancelButtonAction()
                }
            case .authorizedAlways:
                print("authorizedAlways")
                presenter.showAlertPermissionLocation { alertConfigure in
                    self.presenter.openSettingsAppDevice()
                } actionContinue: { alertContinue in
                    self.view?.cancelButtonAction()
                }
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
                presenter.showAlertPermissionLocation { alertConfigure in
                    self.presenter.openSettingsAppDevice()
                } actionContinue: { alertContinue in
                    self.view?.cancelButtonAction()
                }
            @unknown default:
                print("mapkit default")
            }
            
        default:
            break
        }
        
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        view?.cancelButtonAction()
    }
    
}

// MARK: - CLLocationManagerDelegate
extension ConfigurationPermissionCollectionViewCell: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
}

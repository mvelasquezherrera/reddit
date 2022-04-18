//
//  PermissionModel.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import Foundation

public class PermissionModel {
    
    public var imgNamePermission: String?
    public var titlePermission: String?
    public var descriptionPermission: String?
    public var titleBtnAllow: String?
    public var titleBtnCancel: String?
    
    public init(imgNamePermission: String?, titlePermission: String?, descriptionPermission: String?, titleBtnAllow: String?, titleBtnCancel: String?) {
        self.imgNamePermission = imgNamePermission
        self.titlePermission = titlePermission
        self.descriptionPermission = descriptionPermission
        self.titleBtnAllow = titleBtnAllow
        self.titleBtnCancel = titleBtnCancel
    }
    
}

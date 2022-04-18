//
//  ColorPalette.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import UIKit

struct ColorPalette {
    
    struct DesignSystem {
        
        static let primaryColor = UIColor(named: "PrimaryColor")
        static let secondaryColor = UIColor(named: "SecondaryColor")
        static let titleColor = UIColor(named: "titleColor")
        static let descriptionColor = UIColor(named: "descriptionColor")
        
    }
    
    struct Button {
        
        struct Primary {
            static let titleColor = UIColor.white
            static let backgroundColor = DesignSystem.primaryColor
        }
        
        struct PrimaryDisabled {
            static let titleColor = UIColor.white
            static let backgroundColor = UIColor.darkGray
        }
        
        struct Secondary {
            static let titleColor = DesignSystem.secondaryColor
            static let backgroundColor = UIColor.clear
        }
        
        struct Disable {
            static let titleColor = UIColor.white
            static let backgroundColor = DesignSystem.primaryColor
        }
        
        struct Cancel {
            static let titleColor = DesignSystem.descriptionColor
            static let backgroundColor = UIColor.white
        }
        
    }
    
}

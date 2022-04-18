//
//  RoundedCornerButton.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import UIKit

enum RoundedCornerButtonType {
    case primary
    case primaryDisabled
    case secondary
    case cancel
    case disable
}

class RoundedCornerButton: UIButton {
    
    var originalButtonText: String?
    
    var type: RoundedCornerButtonType = .primary {
        didSet {
            setNeedsLayout()
        }
    }
    
    var enable: Bool = true {
        didSet {
            isEnabled = enable
            if enable {
                setEnabled()
            } else {
                setDisabled()
            }
        }
    }
    
    var buttonTitle: String? {
        didSet {
            setTitle(buttonTitle, for: .normal)
        }
    }
    
    var buttonImage: UIImage? {
        didSet {
            setImage(buttonImage, for: .normal)
        }
    }
    
    var buttonBackgroundColor: UIColor? {
        didSet {
            backgroundColor = buttonBackgroundColor
        }
    }
    
    var buttonBorderColor: UIColor? {
        didSet {
            guard let borderColor = buttonBorderColor else { return }
            layer.cornerRadius = bounds.height / 2
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 1
            setNeedsLayout()
        }
    }
    
    var buttonTitleColor: UIColor? {
        didSet {
            setTitleColor(buttonTitleColor, for: .normal)
        }
    }
    
    var cornerRadius: CGFloat? {
        didSet {
            guard let cornerRadius = cornerRadius else { return };    layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
            case .primary: setPrimaryFilled();break;
            case .secondary: setSecondaryFilled();break;
            case .cancel: setCancelFilled();break;
            case .disable:setDisableStyle();break;
            case .primaryDisabled: setPrimaryDisabledFilled();break;
        }
    }
    
}

extension RoundedCornerButton {
    
    private func initialSetup() {
        contentHorizontalAlignment = .left
        layer.cornerRadius = frame.height / 2
    }
    
    private func setEnabled() {
        alpha = 1.0
        
    }
    
    private func setDisabled() {
        alpha = 0.5
    }
    
    private func setDisableStyle() {
        setTitleColor(ColorPalette.Button.Disable.titleColor, for: .normal)
        backgroundColor = ColorPalette.Button.Disable.backgroundColor
        layer.shadowColor = UIColor.clear.cgColor
        setTitleShadowColor(.clear, for: .normal)
        layer.cornerRadius = frame.height / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        enable = false
    }
    
    private func setPrimaryFilled() {
        self.setTitleColor(ColorPalette.Button.Primary.titleColor, for: .normal)
        self.backgroundColor = ColorPalette.Button.Primary.backgroundColor
        self.titleLabel?.font = UIFont(name: "Lato-Regular", size: 16.0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.setTitleShadowColor(.clear, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.enable = true
    }
    
    private func setPrimaryDisabledFilled() {
        self.setTitleColor(ColorPalette.Button.PrimaryDisabled.titleColor, for: .normal)
        self.backgroundColor = ColorPalette.Button.PrimaryDisabled.backgroundColor
        self.titleLabel?.font = UIFont(name: "Lato-Regular", size: 16.0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.setTitleShadowColor(.clear, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.alpha = 0.7
        self.enable = false
    }
    
    private func setSecondaryFilled() {
        setTitleColor(ColorPalette.Button.Secondary.titleColor, for: .normal)
        backgroundColor = ColorPalette.Button.Secondary.backgroundColor
        layer.shadowColor = UIColor.clear.cgColor
        layer.cornerRadius = frame.size.height / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        enable = true
        setTitleShadowColor(.clear, for: .normal)
    }
    
    private func setCancelFilled() {
        setTitleColor(ColorPalette.Button.Cancel.titleColor, for: .normal)
        backgroundColor = .clear
        layer.shadowColor = UIColor.clear.cgColor
        layer.cornerRadius = frame.height / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        enable = true
        setTitleShadowColor(.clear, for: .normal)
    }
    
}

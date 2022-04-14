//
//  CustomLoadingView.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 14/04/22.
//

import UIKit

protocol CustomLoadingViewDelegate: class {
    func startLoadingAnimation()
    func finishLoadingAnimation()
}

class CustomLoadingView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewBackgroundLoading: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - VARIABLES Y CONSTANTES
    weak var delegate: CustomLoadingViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startLoadingAnimation() {
        setStyle()
        loadingView.startAnimating()
    }
    
    func finishLoadingAnimation() {
        loadingView.stopAnimating()
    }

}

// MARK: - Set Style
extension CustomLoadingView {
    
    func setStyle() {
        setStyleViewBackground()
        setStyleViewBackgroundLoading()
        setStyleIndicatorView()
    }
    
    func setStyleViewBackground() {
        viewBackground.backgroundColor = UIColor.gray
        viewBackground.alpha = 0.4
    }
    
    func setStyleViewBackgroundLoading() {
        viewBackgroundLoading.backgroundColor = UIColor.white
        viewBackgroundLoading.alpha = 1
        viewBackgroundLoading.layer.cornerRadius = viewBackgroundLoading.frame.height / 2
    }
    
    func setStyleIndicatorView() {
        loadingView.color = ColorPalette.DesignSystem.primaryColor
    }
    
}

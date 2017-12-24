//
//  LoadingSpinnerView.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

open class LoadingSpinnerView: UIView {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
    var indicatorBackgroundColor: UIColor = UIColor.black
    var alphaToUse: CGFloat = 0.4 {
        didSet {
            self.alpha = self.alphaToUse
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = self.indicatorBackgroundColor
        self.alpha = self.alphaToUse
        self.layer.cornerRadius = 10.0
        
        self.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        activityIndicator.startAnimating()
    }
}

public let kUIViewControllerDefaultLoadingPopupSize: CGSize = CGSize(width: 100.0, height: 100.0)

public extension UIViewController {
    
    public func showLoadingPopupLight(size: CGSize = kUIViewControllerDefaultLoadingPopupSize, offset: CGPoint = CGPoint.zero) {
        self.showLoadingPopup(size: size, offset: offset, indicatorColor: UIColor.black, backgroundColor: UIColor.white)
    }
    
    public func showLoadingPopupNone() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    public func showLoadingPopup(disableUserInteraction: Bool = true, size: CGSize = kUIViewControllerDefaultLoadingPopupSize, offset: CGPoint = CGPoint.zero, indicatorColor: UIColor? = nil, backgroundColor: UIColor? = UIColor.clear, alpha: CGFloat = 0.4) {
        self.hideLoadingPopup()
        
        let loadingView = LoadingSpinnerView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: loadingView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.width))
        constraints.append(NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.height))
        constraints.append(NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: offset.x))
        constraints.append(NSLayoutConstraint(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: offset.y))
        
        for constraint in constraints {
            constraint.isActive = true
        }
        
        if indicatorColor != nil {
            loadingView.activityIndicator.color = indicatorColor
        }
        if backgroundColor != nil {
            loadingView.backgroundColor = backgroundColor
            loadingView.indicatorBackgroundColor = backgroundColor!
        }
        loadingView.alphaToUse = alpha
        
        if disableUserInteraction {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        self.view.updateConstraints()
    }
    
    public func hideLoadingPopup() {
        for view in self.view.subviews {
            if view.isKind(of: LoadingSpinnerView.self) {
                view.removeFromSuperview()
            }
        }
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

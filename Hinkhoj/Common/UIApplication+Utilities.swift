//
//  UIApplication+Utilities.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    // Recursively finds the top most view controller starting from key window
    public class func topViewController() -> UIViewController? {
        let baseVC = UIApplication.shared.keyWindow?.rootViewController
        if let navVC = baseVC as? UINavigationController, let visibleVC = navVC.visibleViewController {
            return visibleVC
        }
        
        if let tabVC = baseVC as? UITabBarController, let selectedVC = tabVC.selectedViewController {
            return selectedVC
        }
        
        if let presentedVC = baseVC?.presentedViewController {
            if presentedVC.isBeingDismissed {
                return baseVC
            } else if let nextPresentedVC = presentedVC.presentedViewController {
                if nextPresentedVC.isBeingDismissed {
                    return presentedVC
                }
                return nextPresentedVC
            }
            return presentedVC.presentedViewController ?? presentedVC
        }
        
        return baseVC
    }
}

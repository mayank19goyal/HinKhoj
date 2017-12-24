//
//  UIViewController+Alerts.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func simpleAlertWithTitleAndMessage(_ titleMessage: (String, String)) {
        
        let unauthorizedTitle = "Unauthorized".localize()
        
        let okAction = AlertAction("OK".localize(), { (cancelpressed) in
            if titleMessage.0 == unauthorizedTitle {
                //Unauthorized user, clear out the keychain data.
            }
        })
        
        showAlert(titleMessage.0, message: titleMessage.1, cancelAction: okAction)
    }
}

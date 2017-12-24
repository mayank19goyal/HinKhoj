//
//  UIViewController+Alerts.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

/**
 The handler to be called when the alert is presented successfully
 */
public typealias AlertPresentationCompletionHandler = (() -> Void)!

public typealias AlertOKCompletionHandler  = (_ indexes: String)-> ()

/**
 The title of the Action to be shown in the button.
 */
public typealias AlertActionTitle = String

/**
 The handler to be called when the action/button is tapped.
 */
public typealias AlertActionCompletionHandler = ((UIAlertAction?) -> Void)!

/**
 The param which could be passed to the showAlert helper method
 */
public typealias AlertAction = (AlertActionTitle, AlertActionCompletionHandler)

public let defaultAction = AlertAction("OK", nil)
public let defaultCancelAction = AlertAction("Cancel", nil)

struct Alert {
    var alertController: UIAlertController
    var animated: Bool
    var alertCompletion: AlertPresentationCompletionHandler?
}

fileprivate var alerts: [Alert] = []
fileprivate var isPresenting = false

public extension UIViewController {
    
    // MARK:- Alert helpers
    /**
     Presents an Alert/ActionSheet to the view
     
     :param: title (Optional) The title of the AlertController.
     :param: message (Optional) The message of the AlertController.
     :param: preferredStyle (Optional) The prefered style of the AlertController.
     :param: animated (Optional) The flag to animate the presentaion of the controller.
     :param: alertCompletion (Optional) The completion block which indicates the alert presentation.
     :param: cancelAction (Default) The Destructive AlertAction of the AlertController.
     :param: otherActions (Optional) Other custom AlertAction of the AlertController.
     
     :example:
     1.
     showAlert(title: "Alert", message: "AlertController Message", cancelAction:AlertAction("Cancel", nil), otherActions: AlertAction("OK", { (action) in
     print("OK Button Tapped")
     }))
     
     2.
     showAlert(title: "Discard Changes?", otherActions: AlertAction("Save", { (action) in
     print("Save Button Tapped")
     }), AlertAction("Discard", { (action) in
     print("Discard Button Tapped")
     }))
     */
    public func showAlert(_ title: String? = nil, message: String? = nil, preferredStyle: UIAlertControllerStyle = UIAlertControllerStyle.alert, animated: Bool? = true, alertCompletion: AlertPresentationCompletionHandler? = nil, cancelAction: AlertAction? = defaultAction, otherActions: AlertAction?...) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if alerts.count == 0 {
            isPresenting = false
        }
        
        if let cancelAction = cancelAction {
            let cancelAction = UIAlertAction(title:  cancelAction.0, style: UIAlertActionStyle.cancel, handler: { (action) in
                if cancelAction.1 != nil {
                    cancelAction.1(action)
                }
                alerts.remove(at: 0)
                isPresenting = false
                self.presentAlert()
            })
            alertController.addAction(cancelAction)
        }
        
        for alrtActn in otherActions {
            if let currentAlertAction = alrtActn {
                alertController.addAction(UIAlertAction(title: currentAlertAction.0, style: UIAlertActionStyle.default, handler: { (action) in
                    if currentAlertAction.1 != nil {
                        currentAlertAction.1(action)
                    }
                    alerts.remove(at: 0)
                    isPresenting = false
                    self.presentAlert()
                }))
            }
        }
        
        alerts.append(Alert(alertController: alertController, animated: animated ?? false, alertCompletion: alertCompletion))
        presentAlert()
    }
    
    fileprivate func presentAlert() {
        if !isPresenting && alerts.count > 0 {
            if let topViewController = UIApplication.topViewController(), (topViewController as? UIAlertController)?.preferredStyle != .alert {
                isPresenting = true
                topViewController.present(alerts[0].alertController, animated: alerts[0].animated, completion: alerts[0].alertCompletion)
            }
        }
    }
    
    public func showPopoverAlert(_ sourceView: UIView, title: String? = nil, message: String? = nil, animated: Bool = true, permittedArrowDirections: UIPopoverArrowDirection = .any, alertCompletion: AlertPresentationCompletionHandler? = nil, cancelAction: AlertAction? = defaultCancelAction, otherActions: AlertAction?...) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if let cancelAction = cancelAction {
            alertController.addAction(UIAlertAction(title: cancelAction.0, style: UIAlertActionStyle.cancel, handler: cancelAction.1))
        }
        
        for alrtActn in otherActions {
            if let currentAlertAction = alrtActn {
                alertController.addAction(UIAlertAction(title: currentAlertAction.0, style: UIAlertActionStyle.default, handler: currentAlertAction.1))
            }
        }
        
        let popoverController = alertController.popoverPresentationController
        popoverController?.sourceView = sourceView
        popoverController?.sourceRect = sourceView.bounds
        popoverController?.permittedArrowDirections = permittedArrowDirections
        self.present(alertController, animated: animated, completion: alertCompletion)
    }
}

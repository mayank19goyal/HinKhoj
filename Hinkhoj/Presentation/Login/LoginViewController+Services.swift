//
//  LoginViewController+Services.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 12/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    func loginByUser() {
        self.showLoadingPopupLight()
        var bodyString = ""
        if AppSetting.sharedInstance.loginSocial == .google {
            let name = AppSetting.sharedInstance.userGoogle?.profile.name ?? ""
            let email = AppSetting.sharedInstance.userGoogle?.profile.email ?? ""
            let deviceID = DeviceID ?? ""
            let id = AppSetting.sharedInstance.userGoogle?.userID ?? ""

            bodyString = String(format: "name=%@&email=%@&system_id=%@&google_tokenId=%@", name, email, deviceID, id)
        } else {
            let name = (AppSetting.sharedInstance.userFacebook?.first_name ?? "") + " " + (AppSetting.sharedInstance.userFacebook?.last_name ?? "")
            let id = AppSetting.sharedInstance.userFacebook?.id ?? ""
            let email = AppSetting.sharedInstance.userFacebook?.email ?? ""
            let deviceID = DeviceID ?? ""
            bodyString = String(format: "name=%@&email=%@&system_id=%@&facebook_tokenId=%@", name, email, deviceID, id)
        }
        let urlPath = String(format: registerUser, bodyString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!)
        BaseService.sharedInstance.executeService(urlPath: urlPath, httpMethodType: "GET", body: nil, completionHandler: { (result, error) in
            
            DispatchQueue.main.async {
                self.hideLoadingPopup()
                if let result = result as? [String: Any] {
                    if let success = result["result"] as? NSNumber, success == 1 {
                        AppSetting.sharedInstance.userProfile = result
                        if AppSetting.sharedInstance.loginSocial == .google {
                            AppSetting.sharedInstance.userProfile!["name"] = AppSetting.sharedInstance.userGoogle?.profile.name ?? ""
                            AppSetting.sharedInstance.userProfile!["email"] = AppSetting.sharedInstance.userGoogle?.profile.email ?? ""
                            if let hasImage = AppSetting.sharedInstance.userGoogle?.profile.hasImage, hasImage == true {
                                AppSetting.sharedInstance.userProfile!["userImage"] = AppSetting.sharedInstance.userGoogle?.profile.imageURL(withDimension: UInt(0.7)).absoluteString ?? ""
                            }
                        } else {
                            AppSetting.sharedInstance.userProfile!["name"] = (AppSetting.sharedInstance.userFacebook?.first_name ?? "") + " " + (AppSetting.sharedInstance.userFacebook?.last_name ?? "")
                            AppSetting.sharedInstance.userProfile!["email"] = AppSetting.sharedInstance.userFacebook?.email ?? ""
                            AppSetting.sharedInstance.userProfile!["userImage"] = AppSetting.sharedInstance.userFacebook?.picture ?? ""
                        }
                        self.navigateToSplash()
                    } else {
                        if let message = result["message"] as? String {
                            self.simpleAlertWithTitleAndMessage(("Login Error", message))
                        }
                    }
                }
                if let error = error {
                    self.simpleAlertWithTitleAndMessage(messageFromError(error))
                }
            }
        })
    }
}

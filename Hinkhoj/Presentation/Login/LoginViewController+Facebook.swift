//
//  LoginViewController+Facebook.swift
//  Medicare
//
//  Created by Mayank Goyal on 10/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit

extension LoginViewController {
    
    @IBAction func loginWithFacebook_TouchUpInside(_ sender: Any) {
        AppSetting.sharedInstance.loginSocial = .facebook
        if (FBSDKAccessToken.current() != nil) {
            // User is logged in, do work such as go to next view controller.
            self.facebookLogin()
        } else {
            let loginManager = LoginManager()
            loginManager.logIn(readPermissions: [ .publicProfile, .email], viewController: self, completion: { (loginResult) in
                switch loginResult {
                case .failed(let error):
                    HinkhojLogs(error.localizedDescription)
                case .cancelled:
                    HinkhojLogs("User cancelled login.")
                case .success(_, _, _):
                    HinkhojLogs("Logged in!")
                    self.facebookLogin()
                }
            })
        }
    }
    
    func facebookLogin() {
        let connection = FBSDKGraphRequestConnection()
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,first_name,last_name,picture.width(1000).height(1000),birthday,gender"])
        DispatchQueue.main.async {
            self.showLoadingPopup()
        }
        connection.add(request, completionHandler: { (response, result, _) in
            DispatchQueue.main.async {
                self.hideLoadingPopup()
                
                if (AppSetting.sharedInstance.userFacebook == nil) {
                    AppSetting.sharedInstance.userFacebook = FacebookUser()
                }
                print(result ?? "")
                if let dict = result as? [String: Any] {
                    if let email = dict["email"] as? String {
                        AppSetting.sharedInstance.userFacebook?.email = email
                    }
                    if let first_name = dict["first_name"] as? String {
                        AppSetting.sharedInstance.userFacebook?.first_name = first_name
                    }
                    if let gender = dict["gender"] as? String {
                        AppSetting.sharedInstance.userFacebook?.gender = gender
                    }
                    if let id = dict["id"] as? String {
                        AppSetting.sharedInstance.userFacebook?.id = id
                    }
                    if let last_name = dict["last_name"] as? String {
                        AppSetting.sharedInstance.userFacebook?.last_name = last_name
                    }
                    if let picture = dict["picture"] as? [String: Any] {
                        if let data = picture["data"] as? [String: Any] {
                            if let url = data["url"] as? String {
                                AppSetting.sharedInstance.userFacebook?.picture = url
                            }
                        }
                    }
                }
                
                self.loginByUser()
            }
        })
        
        connection.start()
    }
}

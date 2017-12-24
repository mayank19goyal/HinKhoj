//
//  AppSetting.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class AppSetting {

    static let sharedInstance = AppSetting()
    
    var loginSocial: SocialLogin = .google
    var userGoogle: GIDGoogleUser?
    var userFacebook: FacebookUser?
    var userProfile: [String: Any]?
    
    //The lazy image object
    lazy var lazyImage: LazyImage = LazyImage()
}

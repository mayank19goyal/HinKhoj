//
//  LoginViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 10/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

let OSType = UIDevice.current.systemName
let DeviceID = UIDevice.current.identifierForVendor?.uuidString

enum SocialLogin {
    case google
    case facebook
}

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var btnWithoutLogin: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnWithoutLogin.layer.borderColor = UIColor(red: 117.0/255.0, green: 119.0/255.0, blue: 120.0/255.0, alpha: 1.0).cgColor
        btnWithoutLogin.layer.cornerRadius = 5.0
        btnWithoutLogin.layer.borderWidth = 1.0
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func navigateToSplash() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "splashViewController") as? SplashViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func btnWithoutLogin_TouchUpInside(_ sender: Any) {
        self.navigateToSplash()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

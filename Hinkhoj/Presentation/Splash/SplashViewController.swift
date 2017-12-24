//
//  SplashViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 11/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imgAnimation: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let gif = UIImage.gifImageWithName("search_loader")
        imgAnimation.image = gif
        
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(SplashViewController.navigateToDashboard), userInfo: nil, repeats: false)
    }
    
    @objc func navigateToDashboard() {
        let storyboard = UIStoryboard(name: "Hinkhoj", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "dashboardViewController") as? DashboardViewController {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  BaseViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 11/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation

let AdMobID = "ca-app-pub-0405801311678246/3307984431"

class BaseViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannerView.adUnitID = AdMobID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func textToSpeech(_ text: String) {
        myUtterance = AVSpeechUtterance(string: text)
        myUtterance.rate = 0.3
        synth.speak(myUtterance)
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

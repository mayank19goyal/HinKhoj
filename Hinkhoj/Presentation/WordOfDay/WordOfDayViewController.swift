//
//  WordOfDayViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 25/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class WordOfDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblWordOfDay: UITableView!
    var dictWordOfDay = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Word Of The Day"
        tblWordOfDay.separatorColor = UIColor.clear
        
        self.addDummyData()
    }
    
    func addDummyData() {
        dictWordOfDay.setValue("THe riveting chemistry between Tiger and Zoya in 'Tiger Zinda Hai' moview has enchanted the audience.", forKey: "Usage")
        dictWordOfDay.setValue("engrossing, gripping, fascinating, absorbing", forKey: "Similar Words/Synonyms")
        dictWordOfDay.setValue("boring, tedious, uninteresting, monotonous", forKey: "Opposite Words/Antonyms")
        dictWordOfDay.setValue("Extremely interesting", forKey: "Word Details")
    }

    @IBAction func back_TouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

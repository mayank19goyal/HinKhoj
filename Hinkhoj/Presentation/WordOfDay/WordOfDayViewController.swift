//
//  WordOfDayViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 25/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

internal struct dataWOD {
    var title: String?
    var value: String?
    var isURL: Bool?
}

class WordOfDayViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblWordOfDay: UITableView!
    var dictWordOfDay: [String: Any] = ["": ""]
    
    internal lazy var wodArray = [dataWOD]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Word Of The Day"
        tblWordOfDay.separatorColor = UIColor.clear
        
        self.bindData()
    }
    
    func bindData() {
        wodArray.removeAll()
        if let example = dictWordOfDay["example"] as? String {
            var value = example
            if let hexample = dictWordOfDay["hexample"] as? String {
                value += "\n\n" + hexample
            }
            wodArray.append(dataWOD(title: "Usage:", value: value, isURL: false))
        }
        if let synonyms = dictWordOfDay["synonyms"] as? String {
            wodArray.append(dataWOD(title: "Similar Words/Synonyms:", value: synonyms, isURL: false))
        }
        if let word_details = dictWordOfDay["word_details"] as? String {
            wodArray.append(dataWOD(title: "Word Details:", value: word_details, isURL: false))
        }
        if let video_url = dictWordOfDay["video_url"] as? String {
            wodArray.append(dataWOD(title: "", value: video_url, isURL: true))
        }
        
        self.tblWordOfDay.reloadData()
//        dictWordOfDay.setValue("THe riveting chemistry between Tiger and Zoya in 'Tiger Zinda Hai' moview has enchanted the audience.", forKey: "Usage")
//        dictWordOfDay.setValue("engrossing, gripping, fascinating, absorbing", forKey: "Similar Words/Synonyms")
//        dictWordOfDay.setValue("boring, tedious, uninteresting, monotonous", forKey: "Opposite Words/Antonyms")
//        dictWordOfDay.setValue("Extremely interesting", forKey: "Word Details")
    }

    @IBAction func back_TouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

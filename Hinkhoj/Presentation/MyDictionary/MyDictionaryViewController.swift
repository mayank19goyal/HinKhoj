//
//  MyDictionaryViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 05/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

enum MyDictionarySectionType {
    case saveWords
    case searchHistory
    case myCommunity
    
    func headerText() -> String {
        switch self {
        case .saveWords:
            return "SAVE WORDS"
            
        case .searchHistory:
            return "SEARCH HISTORY"
            
        case .myCommunity:
            return "MY COMMUNITY"
        }
    }
}

protocol ScrollHeaderMyDictionaryDelegate: class {
    func selectedTab(sender: UIButton)
}

class MyDictionaryViewController: UIViewController, ScrollHeaderMyDictionaryDelegate, UITableViewDelegate, UITableViewDataSource {

    weak var scrollHeaderViewController: ScrollHeaderMyDictionaryViewController?
    var selecteTab: MyDictionarySectionType = .saveWords
    var arrSearchHistory = [String]()
    @IBOutlet weak var tblDictionary: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollHeaderViewController?.designButtoninScrollView(arrButton: [MyDictionarySectionType.saveWords.headerText(), MyDictionarySectionType.searchHistory.headerText(), MyDictionarySectionType.myCommunity.headerText()])
        
        if self.selecteTab == .searchHistory {
            self.getSearhHistory()
        }
    }

    @IBAction func back_TouchUpInside(_ sender: Any) {
        if let controllers = self.navigationController?.viewControllers {
            for subViewController in controllers {
                if subViewController.isKind(of: DashboardViewController.self) {
                    self.navigationController?.popToViewController(subViewController, animated: true)
                    return
                }
            }
        }
    }
    
    func selectedTab(sender: UIButton) {
        self.arrSearchHistory.removeAll()
        switch sender.tag {
        case 500:
            selecteTab = .saveWords
            break;
        case 501:
            selecteTab = .searchHistory
            self.getSearhHistory()
            break;
        case 502:
            selecteTab = .myCommunity
            break;
        default:
            break
        }
        self.tblDictionary.reloadData()
    }
    
    // MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoadScrollFromMyDictionary" {
            if let vc = segue.destination as? ScrollHeaderMyDictionaryViewController {
                scrollHeaderViewController = vc
                scrollHeaderViewController?.headerDelegate = self
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  DashboardViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 11/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit
import SideMenu

enum DashoardSectionType {
    case updates
    case learn
    case tools
    case practice
    
    func headerText() -> String {
        switch self {
        case .updates:
            return "UPDATES"
            
        case .learn:
            return "LEARN"
            
        case .tools:
            return "TOOLS"
            
        case .practice:
            return "PRACTICE"
        }
    }
}

protocol ScrollHeaderDashboardDelegate: class {
    func selectedTab(sender: UIButton)
}

class DashboardViewController: BaseViewController, UITextFieldDelegate, ScrollHeaderDashboardDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtFldSearch: UIView!
    @IBOutlet weak var tblDashboard: UITableView!
    
    weak var scrollHeaderViewController: ScrollHeaderDashboardViewController?
    var selecteTab: DashoardSectionType = .updates
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        tblDashboard.separatorColor = UIColor.clear
        scrollHeaderViewController?.designButtoninScrollView(arrButton: [DashoardSectionType.updates.headerText(), DashoardSectionType.learn.headerText(), DashoardSectionType.tools.headerText(), DashoardSectionType.practice.headerText()])
    }
    
    @objc func navigateToSearch(_ text: String) {
        let storyboard = UIStoryboard(name: "Hinkhoj", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "searchViewController") as? SearchViewController {
            vc.navTitle = text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.navigateToSearch("")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoadScrollFromDashboard" {
            if let vc = segue.destination as? ScrollHeaderDashboardViewController {
                scrollHeaderViewController = vc
                scrollHeaderViewController?.headerDelegate = self
            }
        }
    }
    
    func selectedTab(sender: UIButton) {
        switch sender.tag {
        case 500:
            selecteTab = .updates
            break;
        case 501:
            selecteTab = .learn
            break;
        case 502:
            selecteTab = .tools
            break;
        case 503:
            selecteTab = .practice
            break;
        default:
            break
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

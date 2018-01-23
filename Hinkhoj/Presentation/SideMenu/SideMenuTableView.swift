//
//  SideMenuTableView.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 11/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblMenu: UITableView!
    var arrMenu = ["Saved Word", "Search History", "My Community"]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMenu.separatorColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HinkhojLogs("SideMenu Appearing!")
        // this will be non-nil if a blur effect is applied
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HinkhojLogs("SideMenu Appeared!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        HinkhojLogs("SideMenu Disappearing!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        HinkhojLogs("SideMenu Disappeared!")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return arrMenu.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 60
        } else {
            return 0.1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = Bundle.main.loadNibNamed("TableHeaderView", owner: self, options: nil)?.first as? TableHeaderView
            view?.lblTitle?.text = "My Dictionary".localize()
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
            if let cell = cell as? ProfileTableViewCell {
                cell.lblName.text = "Guest"
                cell.lblEmail.text = "Guest"
                
                if let profile = AppSetting.sharedInstance.userProfile {
                    if let name = profile["name"] as? String {
                        cell.lblName.text = name
                    }
                    if let email = profile["email"] as? String {
                        cell.lblEmail.text = email
                    }
                    if let userImage = profile["userImage"] as? String {
                        AppSetting.sharedInstance.lazyImage.showWithSpinner(imageView: cell.imgProfile, url: userImage, completion: { (_) in
                            cell.imgProfile.backgroundColor = .gray
                            cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.size.height / 2
                        })
                    }
                }
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath)
            if let cell = cell as? DashboardTableViewCell {
                cell.lblTitle.text = arrMenu[indexPath.row]
                cell.seperatorLine.isHidden = true
                if indexPath.section == 0 && indexPath.row == arrMenu.count - 1 {
                    cell.seperatorLine.isHidden = false
                }
                
                cell.imgIcon.image = UIImage(named: arrMenu[indexPath.row])
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
         if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "Hinkhoj", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "myDictionaryViewController") as? MyDictionaryViewController {
                if indexPath.row == 0 {
                    vc.selecteTab = .saveWords
                } else if indexPath.row == 1 {
                    vc.selecteTab = .searchHistory
                } else if indexPath.row == 2 {
                    vc.selecteTab = .myCommunity
                }
                SideMenuManager.menuLeftNavigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

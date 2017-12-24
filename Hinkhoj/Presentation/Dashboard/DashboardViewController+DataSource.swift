//
//  DashboardViewController+DataSource.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 24/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension DashboardViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selecteTab == .updates {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selecteTab == .updates {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordOfDayTableViewCell", for: indexPath)
            if let cell = cell as? WordOfDayTableViewCell {
                let format = DateFormatter()
                format.dateFormat = "dd MMM"
                cell.lblDate.text = format.string(from: Date())
                cell.lblDate.layer.cornerRadius = 25.0
                format.dateFormat = "MMM dd, yyyy"
                cell.lblFullDate.text = format.string(from: Date())
                
                cell.btnShare.addTarget(self, action: #selector(btnShare_TouchUpInside), for: .touchUpInside)
            }
            
            cell.backgroundColor = UIColor.clear
            cell.backgroundView = nil
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func btnShare_TouchUpInside() {
        let activityViewController = UIActivityViewController(
            activityItems: ["Sahre"],
            applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}

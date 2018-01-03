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
            if (dictWOD != nil) {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selecteTab == .updates {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordOfDayTableViewCell", for: indexPath)
            if let cell = cell as? WordOfDayTableViewCell {
                if let dictWord = dictWOD {
                    let format = DateFormatter()
                    if let strDate = dictWord["date"] as? String {
                        format.dateFormat = "yyyy-MM-dd"
                        if let date = format.date(from: strDate) {
                            format.dateFormat = "dd MMM"
                            cell.lblDate.text = format.string(from: date)
                            cell.lblDate.layer.cornerRadius = 25.0
                            format.dateFormat = "MMM dd, yyyy"
                            cell.lblFullDate.text = format.string(from: date)
                        }
                    }
                    
                    if let word = dictWord["word"] as? String {
                        cell.lblEngWord.text = word
                    }
                    
                    if let hin_word = dictWord["hin_word"] as? String {
                        cell.lblHindWord.text = hin_word
                    }
                    
                    cell.btnShare.addTarget(self, action: #selector(btnShare_TouchUpInside), for: .touchUpInside)
                    cell.btnReadMore.addTarget(self, action: #selector(btnReadMore_TouchUpInside), for: .touchUpInside)

                }
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
    
    @objc func btnReadMore_TouchUpInside() {
        let storyboard = UIStoryboard(name: "Hinkhoj", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "wordOfDayViewController") as? WordOfDayViewController {
            if let dictWord = dictWOD {
                vc.dictWordOfDay = dictWord
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

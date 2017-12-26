//
//  WordOfDayViewController+DataSource.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 25/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension WordOfDayViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictWordOfDay.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wodFirstCell", for: indexPath)
            if let cell = cell as? WODFirstTableViewCell {
                
                cell.backgroundView = nil
                cell.backgroundColor = UIColor.clear
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wodSecondCell", for: indexPath)
            if let cell = cell as? WODSecondTableViewCell {
                    if let text = dictWordOfDay.allKeys[indexPath.row - 1] as? String {
                        cell.lblTitle.text = text
                        if let value = dictWordOfDay.object(forKey: text) as? String {
                            cell.lblValue.text = value
                        }
                    }
                cell.backgroundView = nil
                cell.backgroundColor = UIColor.clear
            }
            
            return cell
        }
    }
}

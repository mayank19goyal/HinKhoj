//
//  MyDictionaryViewController+DataSource.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 23/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

extension MyDictionaryViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selecteTab == .saveWords {
            return 0
        } else if selecteTab == .searchHistory {
            return self.arrSearchHistory.count
        } else if selecteTab == .myCommunity {
            return 0
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selecteTab == .searchHistory {
            return 60
        } else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selecteTab == .searchHistory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dictionaryCellIdentifier", for: indexPath)
            if let cell = cell as? MyDictionaryTableViewCell {
                let word = self.arrSearchHistory[indexPath.row]
                cell.lblFirstWord.text = String(word.first as! Character).capitalized
                cell.lblWord.text = word
            }
            
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selecteTab == .searchHistory {
            let storyboard = UIStoryboard(name: "Hinkhoj", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "searchViewController") as? SearchViewController {
                _ = vc.view
                if let word = arrSearchHistory[indexPath.row] as? String {
                    vc.txtFldSearch.text = word
                    vc.navTitle = word
                    vc.searchByWord(word)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }    
}

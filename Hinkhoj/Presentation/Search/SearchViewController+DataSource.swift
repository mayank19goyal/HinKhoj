//
//  SearchViewController+DataSource.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 23/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension SearchViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selecteTab == .meaning {
            return self.arrWordMeanings.count
        } else if selecteTab == .defination {
            return self.arrDefination.count
        } else if selecteTab == .sentenceExample {
            return self.arrSentenceExample.count
        } else if selecteTab == .similarWords {
            return self.arrSynonym.count
        } else if selecteTab == .oppositeWords {
            return self.arrAntonym.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selecteTab == .meaning {
            if selctedIndexPaths.contains(indexPath) {
                return UITableViewAutomaticDimension
            }
            return 60
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selecteTab == .meaning {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath)
            if let cell = cell as? SearchTableViewCell {
                if let dict = self.arrWordMeanings[indexPath.row] as? [String: Any] {
                    if let word = dict["hin_word"] as? String {
                        cell.lblMeaning.text = word
                    }
                    
                    cell.btnExpand.indexPath = indexPath
                    cell.btnExpand.addTarget(self, action: #selector(btnExpand_TouchUpInside), for: .touchUpInside)
                    
                    if let word = dict["htraslitate"] as? String {
                        cell.lblHtraslitate.text = "pr. {" + word + "}"
                        cell.btnSpeak.tag = 2000 + indexPath.row
                        cell.btnSpeak.addTarget(self, action: #selector(btnSpeak_TouchUpInside), for: .touchUpInside)
                    }
                    
                    cell.lblUsageValue.isHidden = false
                    cell.lblUsage.isHidden = false
                    
                    if let word = dict["eng_example"] as? String, !word.isEmpty {
                        cell.lblUsageValue.text = word
                    } else {
                        cell.lblUsageValue.isHidden = true
                        cell.lblUsage.isHidden = true
                    }
                    
                    
                }
            }
            
            cell.selectionStyle = .none
            return cell
        } else if selecteTab == .defination {
            let cell = tableView.dequeueReusableCell(withIdentifier: "definationCellIdentifier", for: indexPath)
            if let cell = cell as? SearchTableViewCell {
                if let dict = self.arrDefination[indexPath.row] as? [String: Any] {
                    if let word = dict["hin_word"] as? String {
                        cell.lblMeaning.text = word
                    }
                }
            }
            
            cell.selectionStyle = .none
            return cell
        } else if selecteTab == .sentenceExample {
            let cell = tableView.dequeueReusableCell(withIdentifier: "definationCellIdentifier", for: indexPath)
            if let cell = cell as? SearchTableViewCell {
                if let dict = self.arrSentenceExample[indexPath.row] as? [String: Any] {
                    if let word = dict["content"] as? String {
                        cell.lblMeaning.text = word
                    }
                }
            }
            
            cell.selectionStyle = .none
            return cell
        } else if selecteTab == .similarWords || selecteTab == .oppositeWords {
            let cell = tableView.dequeueReusableCell(withIdentifier: "similarWordsCellIdentifier", for: indexPath)
            if let cell = cell as? SearchTableViewCell {
                let arrTable = selecteTab == .similarWords ? self.arrSynonym : self.arrAntonym
                if let word = arrTable[indexPath.row] as? String {
                    cell.lblMeaning.text = word
                    cell.lblFirstWord.text = String(word.first as! Character).capitalized
                    cell.lblFirstWord.layer.cornerRadius = cell.lblFirstWord.frame.size.width / 2
                }
            }
            
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selecteTab == .similarWords || selecteTab == .oppositeWords {
            let storyboard = UIStoryboard(name: "Hinkhoj", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "searchViewController") as? SearchViewController {
                _ = vc.view
                let arrTable = selecteTab == .similarWords ? self.arrSynonym : self.arrAntonym
                if let word = arrTable[indexPath.row] as? String {
                    vc.txtFldSearch.text = word
                    vc.navTitle = word
                    vc.searchByWord(word)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func btnSpeak_TouchUpInside(sender: UIButton) {
        if let dict = self.arrWordMeanings[sender.tag - 2000] as? [String: Any] {
            if let word = dict["htraslitate"] as? String {
                self.textToSpeech(word)
            }
        }
    }
    
    @objc func btnExpand_TouchUpInside(sender: CustomButton) {
        if let indexPath = sender.indexPath {
            if selctedIndexPaths.contains(indexPath) {
                for i in 0..<selctedIndexPaths.count {
                    if indexPath == selctedIndexPaths[i] {
                        selctedIndexPaths.remove(at: i)
                    }
                }
            } else {
                selctedIndexPaths.append(indexPath)
            }
        }
        
        self.tblViewSearch.reloadData()
    }
}

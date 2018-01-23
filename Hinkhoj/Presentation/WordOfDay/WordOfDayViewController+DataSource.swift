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
        return wodArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wodFirstCell", for: indexPath)
            if let cell = cell as? WODFirstTableViewCell {
                
                if let word = self.dictWordOfDay["word"] as? String {
                    cell.lblENgWord.text = word
                    cell.lblCharacter.text = String(word.first as! Character).capitalized
                    cell.lblCharacter.clipsToBounds = true
                    cell.lblCharacter.layer.cornerRadius = cell.lblCharacter.frame.size.width / 2
                }
                if let pronunciation = self.dictWordOfDay["pronunciation"] as? String {
                    cell.lblPronunciation.text = pronunciation
                }
                if let hin_word = self.dictWordOfDay["hin_word"] as? String {
                    cell.lblHindiMeaning.text = hin_word
                }
                cell.backgroundView = nil
                cell.backgroundColor = UIColor.clear
            }
            
            return cell
        } else {
            let objWOD = wodArray[indexPath.row - 1]
            if let bool = objWOD.isURL, !bool {
                let cell = tableView.dequeueReusableCell(withIdentifier: "wodSecondCell", for: indexPath)
                if let cell = cell as? WODSecondTableViewCell {
                    
                    cell.lblTitle.text = objWOD.title
                    cell.lblValue.text = objWOD.value
                    
                    cell.backgroundView = nil
                    cell.backgroundColor = UIColor.clear
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "webViewCell", for: indexPath)
                if let cell = cell as? WebViewTableViewCell {
                    if let value = objWOD.value {
                        if let url = URL(string: value) {
                            cell.webView.loadRequest(URLRequest(url: url))
                            cell.webView.reload()
                        }
                    }
                    cell.backgroundView = nil
                    cell.backgroundColor = UIColor.clear
                }
                return cell
            }
        }
    }
    
    @objc func btnSpeak_TouchUpInside(sender: UIButton) {
        self.textToSpeech("")
    }
}

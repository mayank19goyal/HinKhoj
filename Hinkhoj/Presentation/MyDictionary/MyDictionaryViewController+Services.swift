//
//  MyDictionaryViewController+Services.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 23/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

extension MyDictionaryViewController {
    
    func getSearhHistory() {
        if DBManager.shared.openDatabase() {
            do {
                let query = "SELECT word FROM meaningcache"
                let results = try DBManager.shared.database.executeQuery(query, values: nil)
                self.arrSearchHistory.removeAll()
                while results.next() == true {
                    if let words = results.string(forColumn: "word") {
                        self.arrSearchHistory.append(words)
                    }
                }
                self.tblDictionary.reloadData()
            } catch {
                
            }
        }
    }
}

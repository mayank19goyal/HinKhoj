//
//  BusinessLayerManager+SearchWord.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 22/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

extension BusinessLayerManager {

    func seacrhByWordWithDatabase(word: String, urlPath: String, httpMethodType: String, body: String?, completionHandler: @escaping (NSDictionary?, NSError?) -> Void) {
        if (reachability?.isReachable)! {
            self.executeServiceWithDatabse(urlPath: urlPath, httpMethodType: httpMethodType, body: body, completionHandler: { (data, error) in
                if error == nil {
                    if DBManager.shared.openDatabase() {
                        do {
                            if let data = data {
                                try DBManager.shared.database.executeUpdate("INSERT INTO meaningcache VALUES (?, ?, ?, ?)", values: [word.lowercased(), data, Date(), 1])
                            }
                        } catch {
                            
                        }
                    }
                    
                    self.getTheWordMeaningFromDatabase(word: word, completionHandler: { (result, error) in
                        completionHandler(result, error)
                    })
                }
            })
        } else {
            self.getTheWordMeaningFromDatabase(word: word, completionHandler: { (result, error) in
                completionHandler(result, error)
            })
        }
    }
    
    func getTheWordMeaningFromDatabase(word: String, completionHandler: @escaping (NSDictionary?, NSError?) -> Void) {
        if DBManager.shared.openDatabase() {
            do {
                let query = "SELECT meaning FROM meaningcache where word = '" + word + "'"
                let results = try DBManager.shared.database.executeQuery(query, values: nil)
                if results.next() == true {
                    if let data = results.data(forColumn: "meaning") {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            completionHandler(jsonResult, nil)
                        }
                        
                        completionHandler(nil, nil)
                    }
                } else {
                    let error = NSError(domain: "", code: -2010, userInfo: nil)
                    completionHandler(nil, error)
                }
            } catch let error as NSError {
                completionHandler(nil, error)
            }
        }
    }
}

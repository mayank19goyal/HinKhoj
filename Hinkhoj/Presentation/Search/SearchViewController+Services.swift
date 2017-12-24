//
//  SearchViewController+Services.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 13/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension SearchViewController {
    
    func searchByWord(_ word: String) {
        self.showLoadingPopupLight()
        
        let urlPath = String(format: getDictResultByWord, word.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!)
        BaseService.sharedInstance.executeService(urlPath: urlPath, httpMethodType: "GET", body: nil, completionHandler: { (result, error) in
            
            DispatchQueue.main.async {
                self.hideLoadingPopup()
                if let result = result as? [String: Any] {
                    if let arr = result["main_result"] as? NSMutableArray {
                        self.arrWordMeanings = arr
                    }
                    
                    if let arr = result["eng2eng_result"] as? NSMutableArray {
                        self.arrDefination = arr
                    }
                    
                    if let arr = result["eng_synonym_list"] as? NSMutableArray {
                        self.arrSynonym = arr
                    }
                    
                    if let arr = result["eng_antonym_list"] as? NSMutableArray {
                        self.arrAntonym = arr
                    }
                    
                    self.tblViewSearch.reloadData()
                }
                if let error = error {
                    self.simpleAlertWithTitleAndMessage(messageFromError(error))
                }
            }
        })
    }
    
    func searchGetSentenceUsage(_ word: String) {
        self.showLoadingPopupLight()
        
        let urlPath = String(format: getSentenceUsage, word.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!)
        BaseService.sharedInstance.executeService(urlPath: urlPath, httpMethodType: "GET", body: nil, completionHandler: { (result, error) in
            
            DispatchQueue.main.async {
                self.hideLoadingPopup()
                if let result = result as? [String: Any] {
                    if let arr = result["usages"] as? NSMutableArray {
                        self.arrSentenceExample = arr
                    }
                    self.tblViewSearch.reloadData()
                }
                if let error = error {
                    self.simpleAlertWithTitleAndMessage(messageFromError(error))
                }
            }
        })
    }
}

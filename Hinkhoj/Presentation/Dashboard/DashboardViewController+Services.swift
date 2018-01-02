//
//  DashboardViewController+Services.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 12/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

extension DashboardViewController {
    
    func wordOfDayService() {
        self.showLoadingPopupLight()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let urlPath = String(format: wordOfDay, formatter.string(from: Date()))
        BaseService.sharedInstance.executeService(urlPath: urlPath, httpMethodType: "GET", body: nil, completionHandler: { (result, error) in
            
            DispatchQueue.main.async {
                self.hideLoadingPopup()
                if let result = result as? [String: Any] {
                    
                }
                if let error = error {
                    self.simpleAlertWithTitleAndMessage(messageFromError(error))
                }
            }
        })
    }
}

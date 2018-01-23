//
//  BusinessLayerManager+WOD.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 22/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

extension BusinessLayerManager {

    func getWOD(urlPath: String, httpMethodType: String, body: String?, completionHandler: @escaping (NSDictionary?, NSError?) -> Void) {
        if (reachability?.isReachable)! {
            self.executeService(urlPath: urlPath, httpMethodType: httpMethodType, body: body, completionHandler: { (result, error) in
                
            })
        }
    }
}

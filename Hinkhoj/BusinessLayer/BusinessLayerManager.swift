//
//  BusinessLayerManager.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 22/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit
import ReachabilitySwift

class BusinessLayerManager {

    static let sharedInstance = BusinessLayerManager()
    let reachability = Reachability()

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        config.timeoutIntervalForRequest = TimeInterval(60)
        config.timeoutIntervalForResource = TimeInterval(60)
        return URLSession(configuration: config)
    }()
    
    func executeService(urlPath: String, httpMethodType: String, body: String?, completionHandler: @escaping (NSDictionary?, NSError?) -> Void) {
        if (reachability?.isReachable)! {
            print("urlPath-->", urlPath)
            print("body-->", body ?? "")
            URLCache.shared.removeAllCachedResponses()
            let storage = HTTPCookieStorage.shared
            for cookie in storage.cookies! {
                storage.deleteCookie(cookie)
            }
            
            if let url = NSURL(string: urlPath) {
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = httpMethodType
                if let bodyString = body {
                    let jsonData = bodyString.data(using: .utf8, allowLossyConversion: true)
                    request.httpBody = jsonData
                }
                
                request.allHTTPHeaderFields = ["Content-Type": "application/json"]
                let task = session.dataTask(with: request as URLRequest) {data, response, error in
                    do {
                        if let data = data {
                            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                HinkhojLogs(jsonResult.description)
                                
                                var statuscode :NSInteger?
                                if let httpResponse = response as? HTTPURLResponse {
                                    statuscode = httpResponse.statusCode
                                    if statuscode == 200 {
                                        completionHandler(jsonResult, nil)
                                    } else {
                                        //let title = jsonResult.object(forKey: "error") as? String, let message = jsonResult.object(forKey: "message") as? String
                                        if let status = jsonResult.object(forKey: "status") as? Int {
                                            let error = NSError(domain: "", code: status, userInfo: nil)
                                            completionHandler(nil, error)
                                        }
                                    }
                                }
                            } else {
                                if let jsonArr = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                                    HinkhojLogs(jsonArr.description)
                                    var statuscode :NSInteger?
                                    if let httpResponse = response as? HTTPURLResponse {
                                        statuscode = httpResponse.statusCode
                                        if statuscode == 200 {
                                            if jsonArr.count > 0 {
                                                if let dict = jsonArr[0] as? NSDictionary {
                                                    completionHandler(dict, nil)
                                                } else {
                                                    completionHandler(nil, nil)
                                                }
                                            } else {
                                                completionHandler(nil, nil)
                                            }
                                        } else {
                                            if let error = error {
                                                completionHandler(nil, error as NSError)
                                            }
                                        }
                                    }
                                } else {
                                    if let error = error {
                                        HinkhojLogs(error.localizedDescription)
                                        completionHandler(nil, error as NSError)
                                    }
                                }
                            }
                        } else {
                            if let error = error {
                                HinkhojLogs(error.localizedDescription)
                                completionHandler(nil, error as NSError)
                            }
                        }
                    }
                    catch let error as NSError {
                        HinkhojLogs(error.description)
                        if error.code == 3840 {
                            completionHandler(nil, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
                
                task.resume()
            } else {
                let error = NSError(domain: "", code: -1010, userInfo: nil)
                completionHandler(nil, error)
            }
        } else {
            let error = NSError(domain: "", code: -1009, userInfo: nil)
            completionHandler(nil, error)
        }
    }
    
    func executeServiceWithDatabse(urlPath: String, httpMethodType: String, body: String?, completionHandler: @escaping (Data?, NSError?) -> Void) {
        if (reachability?.isReachable)! {
            URLCache.shared.removeAllCachedResponses()
            let storage = HTTPCookieStorage.shared
            for cookie in storage.cookies! {
                storage.deleteCookie(cookie)
            }
            
            if let url = NSURL(string: urlPath) {
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = httpMethodType
                if let bodyString = body {
                    let jsonData = bodyString.data(using: .utf8, allowLossyConversion: true)
                    request.httpBody = jsonData
                }
                
                let task = session.dataTask(with: request as URLRequest) {data, response, error in
                    do {
                        if let data = data {
                            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                
                                var statuscode :NSInteger?
                                if let httpResponse = response as? HTTPURLResponse {
                                    statuscode = httpResponse.statusCode
                                    if statuscode == 200 {
                                        completionHandler(data, nil)
                                    } else {
                                        if let status = jsonResult.object(forKey: "status") as? Int {
                                            let error = NSError(domain: "", code: status, userInfo: nil)
                                            completionHandler(nil, error)
                                        }
                                    }
                                }
                            }
                        } else {
                            if let error = error {
                                completionHandler(nil, error as NSError)
                            }
                        }
                    }
                    catch let error as NSError {
                        if error.code == 3840 {
                            completionHandler(nil, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
                
                task.resume()
            } else {
                let error = NSError(domain: "", code: -1010, userInfo: nil)
                completionHandler(nil, error)
            }
        } else {
            let error = NSError(domain: "", code: -1009, userInfo: nil)
            completionHandler(nil, error)
        }
    }
}

//
//  HinkhojLogs.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 11/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import Foundation

let DBG_LVL: Int = 1
let DBG_INFO: Int = 2
let DBG_WARN: Int = 3
let DBG_ERR: Int = 4
let DBG_VERBOSE: Bool = true

#if DEBUG
    
#if swift(>=2.2)
    func HinkhojLogs(_ message: String, level: Int = 1, file: String = #file, method: String = #function, line: Int = #line) {
        if level<=DBG_LVL {
            if DBG_VERBOSE {
                print("[\(level)]\((file as NSString).lastPathComponent):\(method) line:\(line)\t\tmessage:\(message)", terminator: "")
            } else {
                print("\(message)", terminator: "")
            }
        }
    }
    #else
    func HinkhojLogs(message: String, level: Int = 1, file: String = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__) {
    if level<=DBG_LVL {
    if DBG_VERBOSE {
    print("[\(level)]\((file as NSString).lastPathComponent):\(method) line:\(line)\t\tmessage:\(message)", terminator: "")
    } else {
    print("\(message)", terminator: "")
    }
    }
    }
#endif
    
#else
    
#if swift(>=2.2)
    func HinkhojLogs(_ message: String, level: Int = 1, file: String = #file, method: String = #function,
                      line: Int = #line) {
        
    }
    #else
    func HinkhojLogs(message: String, level: Int = 1, file: String = __FILE__, method: String = __FUNCTION__,
    line: Int = __LINE__) {
    
    }
#endif
    
    
    
#endif




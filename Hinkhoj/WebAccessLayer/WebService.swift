//
//  WebService.swift
//  Medicare
//
//  Created by Mayank Goyal on 04/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

// Production

// Devlopment
let BaseURL = "http://api.hinkhoj.com/dictionary/webservices/"

let registerUser = BaseURL + "register.php?%@"
let getDictResultByWord = BaseURL + "GetDictResultV2.php?word=%@"
let getSentenceUsage = BaseURL + "getsentenceusage.php?key=hk64@89124&word=%@"
let wordOfDay = "http://cloud-cdn.hinkhoj.com/wod-data/%@.json"


//
//  String+Utility.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

public extension String {
    public func localize(_ comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? self)
    }
    
    func base64UrlEncodedString() -> String {
        // Add padding to the end of the string
        var numEqualsNeeded = 4 - (self.count % 4)
        if numEqualsNeeded == 4 { numEqualsNeeded = 0; }
        var padding = ""
        
        for _ in 0 ..< numEqualsNeeded {
            padding += "="
        }
        let base64URIEncodedString = self.replacingOccurrences(of: "_", with: "/").replacingOccurrences(of: "-", with: "+") + padding
        return base64URIEncodedString
    }
    
    func base64EncodedString() -> String {
        
        // Encoding
        guard let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue) else {
            fatalError()
        }
        
        let base64String = plainData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return base64String
    }

}

open class FormatUtility {
    
    open class func formattedPhoneNumber(phoneNumber: String) -> String {
        let mutablePhone = phoneNumber
        if mutablePhone.count == 10 {
            return FormatUtility.formatTenDigitPhone(phoneNumber: mutablePhone)
        } else if mutablePhone.count == 11 {
            let countryCode = String(mutablePhone[mutablePhone.startIndex])
            let tenDigitPhone = String(mutablePhone[mutablePhone.index(mutablePhone.startIndex, offsetBy: 1)...mutablePhone.index(mutablePhone.startIndex, offsetBy: 10)])
            var phone = "+" + countryCode + "-"
            phone += FormatUtility.formatTenDigitPhone(phoneNumber: tenDigitPhone)
            return phone
        } else if mutablePhone.count == 12 {
            let countryCode = String(mutablePhone[mutablePhone.startIndex...mutablePhone.index(mutablePhone.startIndex, offsetBy: 1)])
            let tenDigitPhone = String(mutablePhone[mutablePhone.index(mutablePhone.startIndex, offsetBy: 1)...mutablePhone.index(mutablePhone.startIndex, offsetBy: 10)])
            var phone = "+"
            phone += countryCode + "-"
            phone += FormatUtility.formatTenDigitPhone(phoneNumber: tenDigitPhone)
            return phone
        }
        
        return mutablePhone
    }
    
    private class func formatTenDigitPhone(phoneNumber: String) -> String {
        var mutable = phoneNumber
        if mutable.count == 10 {
            mutable.insert("-", at: mutable.index(mutable.startIndex, offsetBy: 3))
            mutable.insert("-", at: mutable.index(mutable.startIndex, offsetBy: 7))
        }
        return mutable
    }
    
    open class func formattedTimeIn24Hour(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return "\(formatter.string(from: date))"
    }

}

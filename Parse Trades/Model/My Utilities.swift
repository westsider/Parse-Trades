//
//  My Utilities.swift
//  Parse Trades
//
//  Created by Warren Hansen on 3/9/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Utilities {
    
    let formatter = DateFormatter()
    let today = Date()
    
    func convertToDateFrom(string: String, debug: Bool)-> Date {
        if ( debug ) { print("\ndate from is string: \(string)") }
        let dateS    = string
        formatter.dateFormat = "yyyy-MM-dd"  //2018-02-22
        let date:Date = formatter.date(from: dateS)!
        if ( debug ) { print("Convertion to Date: \(date)\n") }
        return date
    }
    
    func convertToStringFrom(date: Date)-> String {
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
    
    func convertToStringNoTimeFrom(date: Date)-> String {
        formatter.dateFormat = "MM/dd/yy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
    
    // convert UTC to local
    func convertUTCtoLocal(debug: Bool, UTC: Date)-> Date {
        if ( debug ) { print("convertUTCtoLocal\nUTC:       \(today)") }
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let todayString = formatter.string(from: Date())
        if ( debug ) { print("Local str: \(todayString)") }
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let local = formatter.date(from: todayString)
        if ( debug ) { print("local date \(local!)") }
        return local!
    }
}

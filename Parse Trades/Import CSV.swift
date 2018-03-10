//
//  Import CSV.swift
//  Parse Trades
//
//  Created by Warren Hansen on 3/9/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift
import CSV

class CSVFeed {
    
    func getPricesFromCSV(debug: Bool) {
      
        let filleURLProject = Bundle.main.path(forResource: "IB_3_9", ofType: "csv")
        let stream = InputStream(fileAtPath: filleURLProject!)!
        let csv = try! CSVReader(stream: stream)
        
        //Acct ID, 2:Symbol,Trade 4:Date/Time,Settle Date,Exchange,8:Type,9:Quantity,10:Price,Proceeds,12:Comm,Fee,Code
        while let row = csv.next() {
           // if ( debug ) { print("\(row)") }
//            let prices = Prices()
//            prices.ticker = ticker
            
            if row[0].contains("Total") || row[7].isEmpty  || row[4].contains("Settle") {
                //return
                //print("----")
            } else {
                let ticker = row[1] as String
                let stringDate = row[4] as String
                let date = Utilities().convertToDateFrom(string: stringDate, debug: false)
                //MARK: TODO - convert to numbers
       
                if let price = Double(row[8]), let comm = Double(row[10]), let quantity = Int(row[7]) {
                    print("\(ticker) \t\(stringDate) \t\(date) \t\(quantity) \t\(price) \t\(comm)")
                }
                
                
                
                
                
            }
            
            //MARK: TODO - converto to numbers
            
//            prices.dateString = date
//            prices.date = Utilities().convertToDateFrom(string: date, debug: false)
//            if let close = Double(row[1]){
//                prices.close = close
//                if (close == 0.00 ) { print("\n========================     Close was 0 for \(ticker)     ===========================\n") }
//            }
//            if let volume = Double(row[2]){
//                prices.volume = volume
//                if (volume == 0.00 ) { print("\n=======================     volume was 0 for \(ticker)     ===========================\n") }
//            }
//            if let open = Double(row[3]) {
//                prices.open = open
//                if (open == 0.00 ) { print("\n========================     open was 0 for \(ticker)     ===========================\n") }
//            }
//            if let high = Double(row[4]){
//                prices.high = high
//                if (high == 0.00 ) { prices.high = lastHigh }
//            } else {
//                prices.high = lastHigh
//            }
//            if let low = Double(row[5]){
//                prices.low = low
//                if (low == 0.00 ) {  prices.low = lastLow }
//            } else {
//                prices.low = lastLow
//            }
//            
//            if (prices.close != 0.00 && prices.open != 0.00  && prices.high != 0.00 && prices.low != 0.00 ) {
//                RealmHelpers().saveSymbolsToRealm(each: prices)
//            }
//            lastLow = prices.high
//            lastHigh = prices.low
        }

    }
}

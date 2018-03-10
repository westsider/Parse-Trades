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
    
    func getPricesFromCSV(fileCalled:String, debug: Bool) {
        
        Trades().deleteAll()
        let filleURLProject = Bundle.main.path(forResource: fileCalled, ofType: "csv")
        let stream = InputStream(fileAtPath: filleURLProject!)!
        let csv = try! CSVReader(stream: stream)
        
        //Acct ID, 2:Symbol,Trade 4:Date/Time,Settle Date,Exchange,8:Type,9:Quantity,10:Price,Proceeds,12:Comm,Fee,Code
        
        while let row = csv.next() {
            // if ( debug ) { print("\(row)") }
            if row[0].contains("Total") || row[7].isEmpty  || row[4].contains("Settle") {
                //print("----")
            } else {
                let ticker = row[1] as String
                let dateString = row[4] as String
                if let price = Double(row[8]), let comm = Double(row[10]), let quantity = Int(row[7]) {
                    Trades().addNewrow(ticker: ticker, dateString: dateString, price: price, comm: comm, quantity: quantity, debug: debug)
                }
            }
        }
        print("\nCSV \(fileCalled) has been saved to realm.")
    }
}

//
//  Trades.swift
//  Parse Trades
//
//  Created by Warren Hansen on 3/9/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

class Trades: Object {
    @objc dynamic var ticker     = ""
    @objc dynamic var dateString = ""
    @objc dynamic var date:Date?
    @objc dynamic var price      = 0.00
    @objc dynamic var comm       = 0.00
    @objc dynamic var quantity   = 0
    @objc dynamic var taskID     = ""
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        print("\nRealm \tCleared!\n")
    }
    
    func addNewrow(ticker:String, dateString:String, price:Double, comm:Double, quantity:Int, debug:Bool  ) {
        
        let date = Utilities().convertToDateFrom(string: dateString, debug: false)
        let realm = try! Realm()
        let trades = Trades()
        trades.ticker = ticker
        trades.dateString = dateString
        trades.date = date
        trades.price = price
        trades.comm = comm
        trades.quantity = quantity
        trades.taskID = NSUUID().uuidString
        try! realm.write({
            realm.add(trades)
        })
        if debug { print("\(ticker) \t\(dateString) \t\(date) \t\(quantity) \t\(price) \t\(comm)") }
    }
    
    func sortAllTrades(debug:Bool)-> Results<Trades> {
        let realm = try! Realm()
        let allTrades = realm.objects(Trades.self).sorted(byKeyPath: "date", ascending: true).filter("ticker == %@", "A")
        if ( debug ) {
            for each in allTrades {
                print("\(each.ticker) \t\(each.dateString)\t\(each.quantity) \t\(each.price) \t\(each.comm)")
            }
        }
        return allTrades
    }
    
    func arrayOfTickers() -> [String] {
        let realm = try! Realm()
        let allTrades = realm.objects(Trades.self).sorted(byKeyPath: "date", ascending: true)
        let tickerArray: [String] = allTrades.map { (ticker: Trades) in
            return ticker.ticker
        }
        let noDuped = removeDuplicates(array: tickerArray)
        return noDuped
    }
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    func sumOneSymbol(ticker:String) {
        let realm = try! Realm()
        let allTrades = realm.objects(Trades.self).sorted(byKeyPath: "date", ascending: true).filter("ticker == %@", ticker)
        // sort each ticker into arrays
        // subtract (Exit from entry price) - comm.
        var buyPrice = 0.0
        var sellPrice = 0.0
        var profit = 0.0
        var cumProfit:[Double] = []
        
        for each in allTrades {
            if each.quantity > 0 {
                buyPrice = each.price
            }
            if each.quantity < 0 {
                sellPrice = each.price
            }
            
            if sellPrice != 0.0 {
                profit = ((sellPrice - buyPrice) * Double(-each.quantity) ) - each.comm
                print("\(each.ticker) \(each.dateString) profit \(profit) = \(buyPrice) - \(sellPrice) * \(each.quantity)  \(each.comm)")
                
                cumProfit.append(profit)
                // save as cum profit object ticker, date, profit
                Cumulative().addProfit(ticker: each.ticker, date: each.date!, dateString: each.dateString, profit: profit)
                sellPrice = 0.0
                
            }
            
        }
        let sum = cumProfit.reduce(0, +)
        if sum != 0.0 { print("Sum: \(sum)\n") }
        /*
         A     2018-02-08     2018-02-08 08:00:00 +0000     48     68.51     -1.0
         A     2018-02-12     2018-02-12 08:00:00 +0000     -48     66.19     -1.08
         
         A     2018-02-14     2018-02-14 08:00:00 +0000     49     67.979     -1.0
         A     2018-02-20     2018-02-20 08:00:00 +0000     -49     73.99     -1.09
         
         A     2018-03-06     2018-03-06 08:00:00 +0000     49     67.6293     -1.0
         A     2018-03-13     2018-03-13 07:00:00 +0000     -49     70.7211     -1.09
         */
    }
}

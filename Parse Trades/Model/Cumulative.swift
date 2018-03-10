//
//  Cumulative.swift
//  Parse Trades
//
//  Created by Warren Hansen on 3/9/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

class Cumulative: Object {
    @objc dynamic var ticker     = ""
    @objc dynamic var dateString = ""
    @objc dynamic var date:Date?
    @objc dynamic var profit      = 0.00
    @objc dynamic var taskID     = ""
    
    func clearCumulative() {
        let realm = try! Realm()
        let weekly = realm.objects(Cumulative.self)
        try! realm.write {
            realm.delete(weekly)
        }
        print("\nRealm \tWklyStats \tCleared!\n")
    }
    
    func addProfit(ticker:String, date:Date, dateString:String, profit:Double) {
    
        let realm = try! Realm()
        let trades = Cumulative()
        trades.ticker = ticker
        trades.dateString = dateString
        trades.date = date
        trades.profit = profit
        trades.taskID = NSUUID().uuidString
        try! realm.write({
            realm.add(trades)
        })
    }
    
    func sortProfit(debug:Bool) {
        let realm = try! Realm()
        let allTrades = realm.objects(Cumulative.self).sorted(byKeyPath: "date", ascending: true)
        if ( debug ) {
            for each in allTrades {
                print("\(each.ticker) \t\(each.dateString)\t\(each.profit)")
            }
        }
    }
}

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
    
    //MARK: - Clear Realm
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        print("\nRealm \tCleared!\n")
    }
    
    func addNewrow(ticker:String, dateString:String, price:Double, comm:Double, quantity:Int  ) {
        
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
        print("\(ticker) \t\(dateString) \t\(date) \t\(quantity) \t\(price) \t\(comm)")
        
    }
}

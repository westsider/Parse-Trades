//
//  ViewController.swift
//  Parse Trades
//
//  Created by Warren Hansen on 3/9/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get Csv Data
        //let fileName = "IB_3_9"
//        CSVFeed().getPricesFromCSV(fileCalled: fileName, debug: true) { (finished) in
//            if finished {
//                //let allTrades = Trades().sortAllTrades(debug: true)
//
//            }
//        }
        
        // Sum profit from each ticker
//        let arrayOfTickers = Trades().arrayOfTickers()
//        Cumulative().clearCumulative()
//        for each in arrayOfTickers {
//            Trades().sumOneSymbol(ticker: each)
//        }
        
        // sort cumulative
        Cumulative().sortProfit(debug: true)
        
        
    }
}


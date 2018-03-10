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
        let fileName = "IB_3_9"
        CSVFeed().getPricesFromCSV(fileCalled: fileName, debug: false) { (finished) in
            if finished {
                let _ = Trades().sortAllTrades(debug: true)
            }
        }
    }


}


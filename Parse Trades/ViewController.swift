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
        
        let _ = CSVFeed().getPricesFromCSV(fileCalled: "IB_3_9", debug: true)
    }


}


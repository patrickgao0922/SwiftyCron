//
//  ViewController.swift
//  SwiftyCron
//
//  Created by patrickgao0922@gmail.com on 01/13/2018.
//  Copyright (c) 2018 patrickgao0922@gmail.com. All rights reserved.
//

import UIKit
import SwiftyCron

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cronString = "39 11 02 08 *"
        let swiftyCron = SwiftyCron(cronString:cronString)
        
        print(swiftyCron?.day)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


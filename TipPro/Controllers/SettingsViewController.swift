//
//  SettingsViewController.swift
//  TipPro
//
//  Created by Ricky Kuang on 11/1/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var taxRate: UITextField!
    @IBOutlet weak var roundingOption: UISegmentedControl!
    @IBOutlet weak var minTip: UITextField!
    @IBOutlet weak var maxTip: UITextField!
    @IBOutlet weak var splitLimit: UITextField!
    
    override func viewDidLoad() {
        taxRate.addDoneButtonOnKeyboard()
        minTip.addDoneButtonOnKeyboard()
        maxTip.addDoneButtonOnKeyboard()
        splitLimit.addDoneButtonOnKeyboard()
        
        let settings = UserDefaultsManager.settings
        roundingOption.selectedSegmentIndex = settings["roundingOption"]!
        minTip.text = String(format: "%d", settings["minTip"]!)
        maxTip.text = String(format: "%d", settings["maxTip"]!)
        splitLimit.text = String(format: "%d", settings["splitLimit"]!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue")
//        UserDefaultsManager.settings = [
//            "roundingOption": roundingOption.selectedSegmentIndex as Int,
//            "minTip": Int(minTip.text!),
//            "maxTip": Int(maxTip.text!),
//            "splitLimit": Int(splitLimit.text!),
//            ] as! Dictionary<String, Int>
    }
}

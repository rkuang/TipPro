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
        configureKeyboards()
        applySettings()
    }
    
    func configureKeyboards() {
        taxRate.addDoneButtonOnKeyboard()
        minTip.addDoneButtonOnKeyboard()
        maxTip.addDoneButtonOnKeyboard()
        splitLimit.addDoneButtonOnKeyboard()
    }
    
    func applySettings() {
        let settings = UserDefaultsManager.settings
        roundingOption.selectedSegmentIndex = settings["roundingOption"]!
        minTip.text = String(format: "%d", settings["minTip"]!)
        maxTip.text = String(format: "%d", settings["maxTip"]!)
        splitLimit.text = String(format: "%d", settings["splitLimit"]!)
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        sender.text = String(format: "%d", sender.text?.toInt() ?? 0)
    }
    
    @IBAction func minEditingEnded(_ sender: UITextField) {
        if sender.text!.toInt() > maxTip.text!.toInt() {
            sender.text = maxTip.text!
        }
    }
    @IBAction func maxEditingEnded(_ sender: UITextField) {
        if sender.text!.toInt() > 100 {
            sender.text = "100";
        } else if sender.text!.toInt() < minTip.text!.toInt() {
            sender.text = minTip.text!
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        print("Done pressed")
        
        if let minTip = minTip.text, let maxTip = maxTip.text, let splitLimit = splitLimit.text {
            UserDefaultsManager.settings = [
                "roundingOption": roundingOption.selectedSegmentIndex,
                "minTip": minTip.toInt(),
                "maxTip": maxTip.toInt(),
                "splitLimit": splitLimit.toInt()
                ]
        }
        self.performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}

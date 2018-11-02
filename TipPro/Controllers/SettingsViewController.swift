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
    
    override func viewDidLoad() {
        taxRate.addDoneButtonOnKeyboard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue")
        print("taxRate = \(taxRate.text!.percentageToFloat())")
        print("roundingOption = \(roundingOption.selectedSegmentIndex)")
//        let vc = segue.destination as! ViewController
//        vc.taxRate = taxRate.text!.percentageToFloat()
    }
}

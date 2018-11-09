//
//  ViewController.swift
//  TipPro
//
//  Created by Ricky Kuang on 4/4/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var taxAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitAmountLabel: UILabel!
    
    @IBOutlet weak var tipSlider: CustomSlider!
    @IBOutlet weak var splitSlider: CustomSlider!
    
    var currentBill = Bill()
    var roundingOption: Int = 0
    var tipPercent: Double = 0.15
    var taxRate: Double = 0.095
    
    @IBAction func tipPercentageChanged(_ sender: UISlider) {
        tipPercent = Double(round(100 * sender.value)) / 100
        UserDefaultsManager.tipPercentage = tipPercent
        
        updateLabels()
    }
    
    @IBAction func updateSplitLabel(_ sender: UISlider) {
        let persons = Double(round(sender.value))
        splitLabel.text = String(format: "%.0f", persons)
        currentBill.setPersons(p: persons)
        updateLabels()
    }
    
    @IBAction func billAmountChanged(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            // update textfield with currency formatting
            sender.text = amountString
            currentBill.setBillAmount(bill: amountString.currencyToDouble())
            updateLabels()
        }
    }
    
    func updateLabels() {
        currentBill.calculateTotal(tipPercent: tipPercent, taxRate: taxRate, rounding: roundingOption)

        // Display updated labels formatted as currency
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        taxAmountLabel.text = formatter.string(from: currentBill.getTaxAmount() as NSNumber)
        tipAmountLabel.text = formatter.string(from: currentBill.getTipAmount() as NSNumber)
        totalAmountLabel.text = formatter.string(from: currentBill.getTotalAmount() as NSNumber)
        tipPercentageLabel.text = String(format: "%.0f%%", tipPercent * 100)
        splitAmountLabel.text = formatter.string(from: currentBill.getSplitAmount() as NSNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountField.addDoneButtonOnKeyboard()
        applySettings()
    }
    
    @IBAction func unwindToMainView(unwindSegue: UIStoryboardSegue) {
        print("handle unwind")
        applySettings()
    }
    
    func applySettings() {
        print(UserDefaultsManager.settings)
        let settings = UserDefaultsManager.settings
        
        roundingOption = settings["roundingOption"]!
        
        tipSlider.minimumValue = Float(settings["minTip"]!) / 100
        tipSlider.maximumValue = Float(settings["maxTip"]!) / 100
        
        tipSlider.value = Float(UserDefaultsManager.tipPercentage)
        tipPercent = UserDefaultsManager.tipPercentage
        
        splitSlider.maximumValue = Float(settings["splitLimit"]!)
        updateLabels()
    }
}


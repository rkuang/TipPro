//
//  ViewController.swift
//  TipPro
//
//  Created by Ricky Kuang on 4/4/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitAmountLabel: UILabel!

    var roundedBillAmount: Float = 0.00
    var roundedTipAmount: Float = 0.00
    var roundedTotalAmount: Float = 0.00
    var roundedTipPercentage: Float = 0.15
    var roundedSplitAmount: Float = 0.00
    
    var persons: Float = 1.0
    var taxRate: Float = 0.095
    var roundingOption: Int = 0
    
    
    @IBAction func updateTipPercentage(_ sender: UISlider) {
        roundedTipPercentage = round(100 * sender.value) / 100
        tipPercentageLabel.text = String(format: "%.0f%%", roundedTipPercentage * 100)
        
        let tipAmount = roundedBillAmount * roundedTipPercentage
        roundedTipAmount = round(100 * tipAmount) / 100
        roundedTotalAmount = roundedBillAmount + roundedTipAmount
        
        let splitAmount = roundedTotalAmount / persons
        roundedSplitAmount = round(100 * splitAmount) / 100
        updateLabels()
    }
    
    @IBAction func updateSplitLabel(_ sender: UISlider) {
        persons = sender.value
        persons.round(.toNearestOrAwayFromZero)
        sender.value = persons
        splitLabel.text = String(format: "%.0f", persons)
        
        let splitAmount = roundedTotalAmount / persons
        roundedSplitAmount = round(100 * splitAmount) / 100
        updateLabels()
    }
    
    @IBAction func billAmountChanged(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
            let billAmount = amountString.currencyToFloat()!
            roundedBillAmount = round(100 * billAmount) / 100
            calculateTotal()
        }
    }
    
    func updateLabels() {
        // Display updated labels formatted as currency
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        tipAmountLabel.text = formatter.string(from: roundedTipAmount as NSNumber)
        totalAmountLabel.text = formatter.string(from: roundedTotalAmount as NSNumber)
        splitAmountLabel.text = formatter.string(from: roundedSplitAmount as NSNumber)
    }
    
    func calculateTotal() {
        let tipAmount = roundedBillAmount * roundedTipPercentage
        roundedTipAmount = round(100 * tipAmount) / 100
        
        let taxAmount = roundedBillAmount * taxRate
        let roundedTaxAmount = round(100 * taxAmount) / 100
        
        roundedTotalAmount = roundedBillAmount + roundedTipAmount + roundedTaxAmount
        
        let splitAmount = roundedTotalAmount / persons
        roundedSplitAmount = round(100 * splitAmount) / 100
        
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmountField.addDoneButtonOnKeyboard()
    }
    
    @IBAction func unwindToMainView(unwindSegue: UIStoryboardSegue) {
        print("handle unwind")
    }

}


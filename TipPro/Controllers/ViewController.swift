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
            calculateTip()
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
    
    func calculateTip() {
        let tipAmount = roundedBillAmount * roundedTipPercentage
        roundedTipAmount = round(100 * tipAmount) / 100
        roundedTotalAmount = roundedBillAmount + roundedTipAmount
        let splitAmount = roundedTotalAmount / persons
        roundedSplitAmount = round(100 * splitAmount) / 100
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addDoneButtonOnKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        billAmountField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        billAmountField.resignFirstResponder()
    }
    
    @IBAction func unwindToMainView(unwindSegue: UIStoryboardSegue) {
        
    }

}


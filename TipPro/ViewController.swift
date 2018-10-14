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
        
        let str = totalAmountLabel.text!
        let totalAmount = Float(str[str.index(after: str.startIndex)...])!
        
        let splitAmount = totalAmount / persons
        roundedSplitAmount = round(100 * splitAmount) / 100
        updateLabels()
    }
    
    func updateLabels() {
        tipAmountLabel.text = String(format: "$%.2f", roundedTipAmount)
        totalAmountLabel.text = String(format: "$%.2f", roundedTotalAmount)
        splitAmountLabel.text = String(format: "$%.2f", roundedSplitAmount)
    }
    
    func calculateTip() {
        let tipAmount = roundedBillAmount * roundedTipPercentage
        roundedTipAmount = round(100 * tipAmount) / 100
        roundedTotalAmount = roundedBillAmount + roundedTipAmount
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "$0.00"
        }
        
        return formatter.string(from: number)!
    }
    
    func currencyToFloat() -> Float? {
        return Float(self[self.index(after:self.startIndex)...])
    }
}


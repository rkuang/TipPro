//
//  Bill.swift
//  TipPro
//
//  Created by Ricky Kuang on 11/2/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import Foundation

class Bill {
    
    private var billAmount: Double = 0.0
    private var taxAmount: Double = 0.0
    private var tipAmount: Double = 0.0
    private var totalAmount: Double = 0.0
    
    private var persons: Double = 1.0
    private var splitAmount: Double = 0.0
    
    func getTaxAmount() -> Double {
        return taxAmount
    }
    
    func getTipAmount() -> Double {
        return tipAmount
    }
    
    func getTotalAmount() -> Double {
        return totalAmount
    }
    
    func getSplitAmount() -> Double {
        return splitAmount
    }
    
    func setBillAmount(bill: Double) {
        billAmount = bill
    }
    
    func setPersons(p: Double) {
        persons = p
        splitAmount = round(100 * (totalAmount / persons)) / 100
    }
    
    func calculateTotal(tipPercent: Double, taxRate: Double) {
        tipAmount = round(100 * billAmount * tipPercent) / 100
//        taxAmount = round(100 * billAmount * taxRate) / 100
        
        totalAmount = round(100 * (billAmount + taxAmount + tipAmount)) / 100
        splitAmount = round(100 * (totalAmount / persons)) / 100
    }
}

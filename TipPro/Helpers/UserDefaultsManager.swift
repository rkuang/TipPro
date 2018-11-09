//
//  UserDefaultsManager.swift
//  TipPro
//
//  Created by Ricky Kuang on 11/7/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static let SETTINGS_KEY: String = "settings"
    static let TIP_KEY: String = "tip"
    
    static var settings: Dictionary<String, Int> {
        get {
            return UserDefaults.standard.dictionary(forKey: SETTINGS_KEY) as! [String: Int]? ??
                ["minTip": 10, "splitLimit": 6, "maxTip": 20, "roundingOption": 0]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: SETTINGS_KEY)
        }
    }
    
    static var tipPercentage: Double {
        get {
            return UserDefaults.standard.object(forKey: TIP_KEY) as! Double? ?? 0.15
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TIP_KEY)
        }
    }
}

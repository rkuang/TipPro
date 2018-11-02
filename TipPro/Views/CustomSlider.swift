//
//  CustomSlider.swift
//  TipPro
//
//  Created by Ricky Kuang on 10/14/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

@IBDesignable class CustomSlider: UISlider {
    
    var height: CGFloat = 5.0;
    
    @IBInspectable var trackHeight: CGFloat {
        get {
            return self.height
        }
        set {
            self.height = newValue
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = self.height
        return newBounds
    }
}

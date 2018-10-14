//
//  CustomSlider.swift
//  TipPro
//
//  Created by Ricky Kuang on 10/14/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 5
        return newBounds
    }
}

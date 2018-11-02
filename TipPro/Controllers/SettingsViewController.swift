//
//  SettingsViewController.swift
//  TipPro
//
//  Created by Ricky Kuang on 11/1/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue")
        let vc = segue.destination as! ViewController
        vc.totalAmountLabel.text = "Works!"
    }
}

//
//  DarkDatePicker.swift
//  kimlic
//
//  Created by İzzet Öztürk on 9.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

class DarkDatePicker: UIDatePicker {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            inputView?.backgroundColor = self.keyboardToolbar.backgroundColor
            self.setValue(UIColor.white, forKey: "textColor")
        }
    }
}

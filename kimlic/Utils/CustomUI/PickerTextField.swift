//
//  PickerTextField.swift
//  kimlic
//
//  Created by paltimoz on 4.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import TextFieldEffects

class PickerTextField: HoshiTextField {
    
    
    let padding = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Avoid keyboard to show up
        self.inputView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Avoid keyboard to show up
        self.inputView = UIView()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Avoid cut and paste option show up
        if (action == #selector(self.cut(_:))) {
            return false
        } else if (action == #selector(self.paste(_:))) {
            return false
        } else if (action == #selector(self.replace(_:withText:))) {
            return false
        } else if (action == #selector(self.select(_:))) {
            return false
        } else if (action == #selector(self.selectAll(_:))) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}

//
//  UITextFieldExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit


private var __maxLengths = [UITextField: Int]()
extension UITextField {
    
    
    func greenCheckIcon() {
        addRightIcon(image: UIImage(named: "green_check_icon"))
    }
    
    func blueCheckIcon() {
        addRightIcon(image: UIImage(named: "blue_check_icon"))
    }
    
    func warningIcon() {
        addRightIcon(image: UIImage(named: "warning_icon"))
    }
    
    func addRightIcon(image: UIImage?) {
        if image != nil {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            self.rightView = imageView
            self.rightView?.frame = imageView.frame
            self.rightViewMode = .always
        }
    }    
    
    func removeIcon() {
        self.rightViewMode = .never
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let text = textField.text
        textField.text = text?.safelyLimitedTo(length: maxLength)
    }
    
    
}



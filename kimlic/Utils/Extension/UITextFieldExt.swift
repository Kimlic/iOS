//
//  UITextFieldExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit

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
    
}

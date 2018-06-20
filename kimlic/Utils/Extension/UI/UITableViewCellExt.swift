//
//  UITableViewCellExt.swift
//  kimlic
//
//  Created by izzet öztürk on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    public var disclosureIndicatorColor: UIColor? {
        get {
            return arrowButton?.tintColor
        }
        set {
            var image = arrowButton?.backgroundImage(for: .normal)
            image = image?.withRenderingMode(.alwaysTemplate)
            arrowButton?.tintColor = newValue
            arrowButton?.setBackgroundImage(image, for: .normal)
        }
    }
    
    public func updateDisclosureIndicatorColorToTintColor() {
        self.disclosureIndicatorColor = self.window?.tintColor
    }
    
    private var arrowButton: UIButton? {
        var buttonView: UIButton?
        self.subviews.forEach { (view) in
            if view is UIButton {
                buttonView = view as? UIButton
                return
            }
        }
        return buttonView
    }
}

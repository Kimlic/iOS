//
//  UIStackViewExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 27.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func setBackgroundColor(colors: [UIColor], cornerRadius: CGFloat? = nil) {
        let backgroundView: UIView = UIView()
        backgroundView.layer.cornerRadius = cornerRadius ?? 0.0
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(backgroundView, at: 0)
        backgroundView.backgroundColor = GradiantColor.convertGradientToColour(colors: colors, frame: self.frame, type: .topBottom).color
        backgroundView.pin(to: self)
    }
}

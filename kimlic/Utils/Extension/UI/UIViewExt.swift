//
//  UIViewExt.swift
//  kimlic
//
//  Created by izzet öztürk on 29.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//
import UIKit
import Foundation

extension UIView {
    
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func setGradientBackgroundColor(colors: [UIColor], type: GradientPoint) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = colors.map({ $0.cgColor })
        layer.startPoint = type.draw().x
        layer.endPoint = type.draw().y
        self.layer.addSublayer(layer)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    public enum UIViewBorderSide {
        case top, bottom, left, right
    }
    
    public func addBorder(side: UIViewBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
}

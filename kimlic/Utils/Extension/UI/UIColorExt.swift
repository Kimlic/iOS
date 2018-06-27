//
//  UIColorExt.swift
//  kimlic
//
//  Created by izzet öztürk on 20.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var waterBlue: UIColor {
        return UIColor(red: 11.0 / 255.0, green: 107.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var pinCheckBlue: UIColor {
        return UIColor(red: 21.0 / 255.0, green: 118.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var linkcolor: UIColor {
        return UIColor(red: 145.0 / 255.0, green: 217.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    @nonobjc class var buttonLightGreen: UIColor {
        return UIColor(red: 152.0 / 255.0, green: 217.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var buttonDarkGreen: UIColor {
        return UIColor(red: 120.0 / 255.0, green: 160.0 / 255.0, blue: 11.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var popupButtonLightBlue: UIColor {
        return UIColor(red: 70.0 / 255.0, green: 191.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    @nonobjc class var popupButtonDarkBlue: UIColor {
        return UIColor(red: 0.0, green: 148.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var inActiveText: UIColor {
        return UIColor(red: 125.0 / 255.0, green: 190.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    @nonobjc class var warningOrange: UIColor {
        return UIColor(red: 1.0, green: 97.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var lightBlueGrey: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 226.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var blueGradianteColors: [UIColor] {
        return [self.popupButtonLightBlue, self.popupButtonDarkBlue]
    }
    @nonobjc class var greenGradianteColors: [UIColor] {
        return [self.buttonLightGreen, self.buttonDarkGreen]
    }
    @nonobjc class var orangeGradianteColors: [UIColor] {
        return [UIColor(red: 255.0 / 255.0, green: 130.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0),
        UIColor(red: 244.0 / 255.0, green: 87.0 / 255.0, blue: 17.0 / 255.0, alpha: 1.0),
        UIColor(red: 221.0 / 255.0, green: 68.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)]
    }
}
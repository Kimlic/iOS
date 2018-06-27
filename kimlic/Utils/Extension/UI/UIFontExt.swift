//
//  UIFontExt.swift
//  kimlic
//
//  Created by izzet öztürk on 20.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

extension UIFont {
    class var headline: UIFont {
        return UIFont(name: "Muli-Regular", size: 42.0)!
    }
    class var popupHeader: UIFont {
        return UIFont(name: "Muli-Regular", size: 36.0)!
    }
    class var popupButtonText: UIFont {
        return UIFont(name: "Muli-SemiBold", size: 28.0)!
    }
    class var bodyText: UIFont {
        return UIFont(name: "Muli-Regular", size: 24.0)!
    }
    class var popupText: UIFont {
        return UIFont(name: "Muli-Light", size: 24.0)!
    }
}
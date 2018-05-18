//
//  AppDelegateExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 30.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit
extension AppDelegate {
    class func isIPhone5s () -> Bool{
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 568.0
    }
    class func isIPhone6 () -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 667.0
    }
    class func isIPhone6Plus () -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 736.0
    }
    
    class func isTablet() -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) < 568.0
    }
}

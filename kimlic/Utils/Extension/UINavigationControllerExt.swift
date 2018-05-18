//
//  UINavigationControllerExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 24.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    
    func popRootViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: true)
        CATransaction.commit()
    }
    
    func pushViewControllerWithHandler(tarVC: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(tarVC, animated: true)
        CATransaction.commit()
    }
    
    
}

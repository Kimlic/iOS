//
//  BaseVC.swift
//  kimlic
//
//  Created by ibrahim özdemir on 18.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ibrahim - Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

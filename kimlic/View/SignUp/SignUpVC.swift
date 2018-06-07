//
//  SignUpVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import PhoneNumberKit

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func newIdentityButtonPressed(_ sender: Any) {
//        UIUtils.navigateToTouchID(self)
//        UIUtils.navigateToTutorial(self)
        UIUtils.showPasscodeVC(vc: self, pageType: .create)
    }
    
    

}

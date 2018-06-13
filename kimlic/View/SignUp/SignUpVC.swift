//
//  SignUpVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func newIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTutorial(self)
    }
    
    @IBAction func recoverIdentityButtonPressed(_ sender: Any) {
//        UIUtils.navigateToProfile(self)
//        UIUtils.navigateToTerms(self)
//        UIUtils.navigateToVerification(self, email: "izzet.ozturk@gmail.com.tr")
        UIUtils.showPasscodeVC(vc: self, pageType: .create)
    }
}

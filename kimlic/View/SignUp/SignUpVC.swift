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
//        UIUtils.navigateToTerms(self, nextPage: .accountRecovery)
//        UIUtils.navigateToEmail(self)
//        UIUtils.navigateToUserInfo(self)
//        UIUtils.navigateToVerification(self, email: "izzeto@ratel.com.tr")
//        UIUtils.navigateToTutorial(self)
//        UIUtils.navigateToProfile(self)
//        UIUtils.navigateToPhoneNumber(self)
//        UIUtils.navigateToMnemonicCreate(self)
        UIUtils.navigateToTutorial(self)
    }
}

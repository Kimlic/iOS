//
//  SignUpVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var newIdentityButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default views
        setupView()
    }
    
    private func setupView() {
        newIdentityButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: newIdentityButton.frame, type: .topBottom).color
        
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
//        UIUtils.navigateToTutorial(self)
//        UIUtils.navigateToProfile(self)
//        UIUtils.navigateToTouchID(self)
//        UIUtils.navigateToMnemonicVerification(self)
//        UIUtils.navigateToSettings(self)
        UIUtils.showPasscodeVC(vc: self, pageType: .confirm)
    }
}

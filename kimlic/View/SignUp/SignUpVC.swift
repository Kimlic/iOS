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
        PopupGenerator.createPopupNew(controller: self, type: .error, popup: Popup(title: "ABC", message: "TEst", buttonTitle: nil))
//        PopupGenerator.createPopupNew(controller: self, type: .error, popup: Popup())
//        UIUtils.navigateToTerms(self, nextPage: .accountRecovery)
//        UIUtils.navigateToEmail(self)
//        UIUtils.navigateToUserInfo(self)
//        UIUtils.navigateToVerification(self, email: "izzeto@ratel.com.tr")
//        UIUtils.navigateToTutorial(self)
//        UIUtils.navigateToProfile(self)
//        UIUtils.navigateToPhoneNumber(self)
//        UIUtils.navigateToMnemonicCreate(self)
//        UIUtils.navigateToMnemonicImport(self)
//        UIUtils.navigateToTutorial(self)
//        UIUtils.navigateToProfile(self)
//        UIUtils.navigateToTouchID(self)
//        UIUtils.navigateToMnemonicVerification(self)
//        UIUtils.navigateToSettings(self)
//        UIUtils.showPasscodeVC(vc: self, pageType: .confirm)
//        UIUtils.navigateToMessage(self, messageType: .accountLinkSuccessfull, message: Message(icon: nil, title: nil, desc: "Burasıda mesaj alanı bakalım nasıl olacak"))
    }
}

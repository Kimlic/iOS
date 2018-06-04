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
        do {
            let phoneNumberKit = PhoneNumberKit()
            let verificatePhone = try phoneNumberKit.parse("+905439316168")
            UIUtils.navigateToPhoneVerification(self, phoneNumber: verificatePhone)
        }catch {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "phoneNotValidTitle".localized, message: "phoneNotValidMessage".localized, buttonTitle: "phoneNotValidButtonTitle".localized))
        }
    }
    
    

}

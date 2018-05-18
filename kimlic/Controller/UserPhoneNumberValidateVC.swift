//
//  UserPhoneNumberValidateVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import PhoneNumberKit

class UserPhoneNumberValidateVC: UIViewController {
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var txtPhoneVerifacitionCode: UITextField!
    @IBOutlet weak var btnResend: RoundButton!
    @IBOutlet weak var imgHexagon: UIImageView!
    @IBOutlet weak var imgHexagonContent: UIImageView!
    
    var phoneNumber: PhoneNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPhoneNumber.text = "+\(phoneNumber.countryCode) " + phoneNumber.adjustedNationalNumber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Animz.fadeIn(image: imgHexagonContent, duration: Animz.time06)
        Animz.fadeIn(image: imgHexagon, duration: Animz.time06)
    }
    
    
    @IBAction func textChange(_ sender: Any) {
        
        let code = txtPhoneVerifacitionCode.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard code?.count == 6 else {
            return
        }
        
        txtPhoneVerifacitionCode.text = code
        UIUtils.showLoading()
        PhoneWebServiceRequest().verifyPhone(verifiyCode: code, completion: { (phoneResponse) in
            if let verified = phoneResponse?.verified, verified {
                Defaults[.phone] = phoneResponse?.value
                Defaults[.phoneCountryCode] = phoneResponse?.countryCode
                Defaults[.phoneVerified] = true
                UIUtils.stopLoading()
                let rootController = self.navigationController?.viewControllers.first as! UserProfileVC
                self.navigationController?.popRootViewControllerWithHandler(completion: {
                    rootController.setUserProfileLevel(type: .create)
                    PopupGenerator.createPopup(controller: rootController, type: .success, popup: Popup())
                })
            }else {
                UIUtils.stopLoading()
                PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "incorrectCodeTitle".localized, message: "incorrectCodeMessage".localized, buttonTitle: "incorrectCodeButtonTitle".localized))
                self.btnResend.isEnabled = true
            }
        })
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnResendPressed(_ sender: Any) {
        UIUtils.showLoading()
        PhoneWebServiceRequest().resendVerifiyCode { (phoneResponse) in
            if phoneResponse != nil {
                UIUtils.stopLoading()
                let popup = Popup(title: "resendCodeTitle".localized, message: "resendCodeMessage".localized, image: nil, buttonTitle: "resendCodeButtonTitle".localized)
                PopupGenerator.createPopup(controller: self, type: .success, popup: popup)
            }else {
                UIUtils.stopLoading()
                PopupGenerator.createPopup(controller: self, type: .error, popup: Popup())
            }
        }
    }
    
    
}

//
//  VerificationCodeVC.swift
//  kimlic
//
//  Created by izzet öztürk on 6.12.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit
import SmileLock
import SwiftyUserDefaults


class VerificationCodeVC: UIViewController {
    
    @IBOutlet weak var stackViewLbl: UIStackView!
    @IBOutlet weak var lblVerificationCode: UILabel!
    
    //MARK: Property
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 4
    
    var pageType: VerificationCodePageType!
    var qrCode: String?
    var baseController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create PasswordContainerView
        passwordContainerView = PasswordContainerView.create(in: stackViewLbl, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButtonLocalizedTitle = "delete"
        passwordContainerView.touchAuthenticationEnabled = false
        
        
        //customize password UI
        passwordContainerView.tintColor = Constants.Colors.textGray
        passwordContainerView.highlightedColor = Constants.Colors.appBlue
        
        
        setPageLbl()
        
    }
    
    
    func setPageLbl() {
        
        switch pageType {
            
        case .create:
            lblVerificationCode.text = "createVerificationCode".localized
            break
            
        case .createConfirm:
            lblVerificationCode.text = "confirmVerificationCode".localized
            break
            
        case .verificate:
            lblVerificationCode.text = "verificateVerificationCode".localized
            break
        case .none:
            break
        case .some(_):
            break
        }
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        if pageType == VerificationCodePageType.createConfirm {
            Defaults[.verificationCodeEnable] = nil
            Defaults[.verificationCode] = nil
        }
        dismiss(animated: true, completion: nil)
    }
    
}


extension VerificationCodeVC: PasswordInputCompleteProtocol {
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {}
    
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        
        switch pageType {
            
        case .create:
            do {
                UIUtils.showLoading()
                Defaults[.verificationCodeEnable] = true
                Defaults[.verificationCode] = input
                dismiss(animated: true, completion: {
                    UIUtils.presentVerificationCodeVC(vc: self.baseController, pageType: .createConfirm, qrCode: nil, completion: {
                        UIUtils.stopLoading()
                    })
                })
            }catch {
                UIUtils.stopLoading()
            }
            break
        case .createConfirm:
            if input == Defaults[.verificationCode] {
                Defaults[.verificationCodeEnable] = true
                Defaults[.verificationCode] = input
                dismiss(animated: true, completion: {
                    UIUtils.navigateToUserBasicProfile(vc: self.baseController)
                })
            } else {
                passwordContainerView.wrongPassword()
            }
            
            break
            
        case .verificate:
            if input == Defaults[.verificationCode] {
                dismiss(animated: true, completion: {
                    UIUtils.authenticationWebServiceRequest(controller: self.baseController, qrCode: self.qrCode)
                })
            } else {
                passwordContainerView.wrongPassword()
            }
            break
        case .none:
            break
        case .some(_):
            break
        }
        
        
    }
}

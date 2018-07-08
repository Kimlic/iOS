//
//  PasscodeVC.swift
//  kimlic
//
//  Created by izzet öztürk on 6.12.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit
import SmileLock
import SwiftyUserDefaults

class PasscodeVC: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var bodyStackView: UIStackView!
    
    //MARK: Property
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 4
    var pageType: PasscodePageType = .confirm
    var tmpCode: String?
    var rootVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        changeLabelText()
    }
    
    private func changeLabelText() {
        switch pageType {
        case .confirm:
            infoLabel.text = "confirmPasscode".localized
        case .create:
            infoLabel.text = "createPasscode".localized
        case .createConfirm:
            infoLabel.text = "createConfirmPasscode".localized
        case .update:
            infoLabel.text = "updatePasscode".localized
        case .delete:
            infoLabel.text = "deletePasscode".localized
        }
    }
    
    private func setupView() {
        //create PasswordContainerView
        passwordContainerView = PasswordContainerView.create(in: bodyStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButtonLocalizedTitle = "delete"
        passwordContainerView.touchAuthenticationEnabled = false
        passwordContainerView.isVibrancyEffect = true
        
        // Change label color
        for view in passwordContainerView.passwordInputViews {
            view.label.textColor = UIColor.white
            view.highlightBackgroundColor = UIColor.passcodeLightBlue
            view.layer.borderColor = UIColor.passcodeLightBlue.cgColor
            view.label.font = UIFont.boldSystemFont(ofSize: view.label.font.pointSize)
        }
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }    
}
extension PasscodeVC: PasswordInputCompleteProtocol {
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {}
    
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        switch self.pageType {
        case .confirm:
            if validatePasscode(input: input) {
                dismiss(animated: true, completion: nil)
            }
        case .create:
            UIUtils.showLoading()
            dismiss(animated: true) {
                UIUtils.showPasscodeVC(vc: self.rootVC, pageType: .createConfirm, tmpCode: input)
                UIUtils.stopLoading()
            }
        case .createConfirm:
            if tmpCode == input {
                Defaults[.passcode] = input
                UIUtils.navigateToMessage(self.rootVC, messageType: .passcodeSuccessfull)
                dismiss(animated: true, completion: nil)
            }else {
                passwordContainerView.wrongPassword()
            }
        case .update:
            if validatePasscode(input: input) {
                UIUtils.showLoading()
                dismiss(animated: true) {
                    UIUtils.showPasscodeVC(vc: self.rootVC, pageType: .create)
                    UIUtils.stopLoading()
                }
            }
        case .delete:
            if validatePasscode(input: input) {
                Defaults[.passcode] = nil
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func validatePasscode(input: String) -> Bool {
        guard input == Defaults[.passcode] else {
            passwordContainerView.wrongPassword()
            return false
        }
        return true
    }
}


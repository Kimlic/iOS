//
//  PhoneVerificationVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import SwiftyUserDefaults
import PhoneNumberKit

class PhoneVerificationVC: UIViewController {
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var firstNumberTextField: PinTextField!
    @IBOutlet weak var secondNumberTextField: PinTextField!
    @IBOutlet weak var thirdNumberTextField: PinTextField!
    @IBOutlet weak var fourthNumberTextField: PinTextField!
    
    var phoneNumber: PhoneNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default value
        setupView()
        
        
        
    }
    
    
    
    
    private func setupView() {
        lblPhoneNumber.text = "Code sent to +\(phoneNumber.countryCode) \(phoneNumber.adjustedNationalNumber())"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstNumberTextField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        
        var text = sender.text
        
        if (text?.utf16.count)! >= 1 {
            sender.text = String((text?.last)!)
            
            switch sender {
            case firstNumberTextField:
                secondNumberTextField.becomeFirstResponder()
            case secondNumberTextField:
                thirdNumberTextField.becomeFirstResponder()
            case thirdNumberTextField:
                fourthNumberTextField.becomeFirstResponder()
            case fourthNumberTextField:
                self.verifyAndNavigate()
            default:
                break
            }
        } else if text?.utf16.count == 0 {
            switch sender {
            case firstNumberTextField:
                firstNumberTextField.becomeFirstResponder()
            case secondNumberTextField:
                firstNumberTextField.becomeFirstResponder()
            case thirdNumberTextField:
                secondNumberTextField.becomeFirstResponder()
            case fourthNumberTextField:
                thirdNumberTextField.becomeFirstResponder()
            default:
                firstNumberTextField.becomeFirstResponder()
            }
            
        }
    }
    @IBAction func didEditingBegin(_ sender: UITextField) {
        sender.backgroundColor = UIColor.white
    }
    
    @IBAction func didEditingEnd(_ sender: UITextField) {
        if let count = sender.text?.count, count <= 0 {            
            sender.backgroundColor = UIColor(white: 0, alpha: 0.02)
        }
    }
    
    @IBAction func changePhoneButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        self.verifyAndNavigate()
    }
    
    private func verifyAndNavigate() {
        if self.codeVerify() {
            UIUtils.navigateToMessage(self, messageType: .successPhoneNumber)
        }else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "incorrectCodeTitle".localized, message: "incorrectCodeMessage".localized, buttonTitle: "incorrectCodeButtonTitle".localized))
        }
    }
    
    private func codeVerify() -> Bool {
        var code = ""
        guard let firstText = firstNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstText.isEmpty else {
            return false
        }
        code += firstText
        guard let secondText = secondNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !secondText.isEmpty else {
            return false
        }
        code += secondText
        guard let thirdText = thirdNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !thirdText.isEmpty else {
            return false
        }
        code += thirdText
        guard let fourthText = fourthNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !fourthText.isEmpty else {
            return false
        }
        code += fourthText
        
        guard code == "1234" else {
            return false
        }
        
        return true
    }
    
}

extension PhoneVerificationVC: PinTexFieldDelegate {
    
    func didPressBackspace(_ textField: PinTextField) {
        self.textFieldDidChange(textField)
    }
    
}

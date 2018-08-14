//
//  VerificationVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit
import PhoneNumberKit
import Alamofire
import Quorum

class VerificationVC: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var firstNumberTextField: PinTextField!
    @IBOutlet weak var secondNumberTextField: PinTextField!
    @IBOutlet weak var thirdNumberTextField: PinTextField!
    @IBOutlet weak var fourthNumberTextField: PinTextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    
    var phoneNumber: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default value
        setupView()
    }
    
    private func setupView() {
        
        verifyButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: verifyButton.frame, type: .topBottom).color
        
        let address = email ?? "\(PartialFormatter().formatPartial(phoneNumber ?? ""))"
        addressLabel.text = address
        
        if email != nil {
            changeButton.setTitle("Change email address", for: .normal)
            icon.image = #imageLiteral(resourceName: "email_with_circle")
        }else {
            changeButton.setTitle("Change phone number", for: .normal)
        }
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
                break
//                self.verifyAndNavigate()
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
        sender.backgroundColor = UIColor.pinCheckBlue
        sender.layer.borderColor = UIColor.white.cgColor
        sender.layer.borderWidth = 2
        sender.layer.cornerRadius = 5
    }
    
    @IBAction func didEditingEnd(_ sender: UITextField) {
        if let count = sender.text?.count, count <= 0 {            
            sender.backgroundColor = UIColor.clear            
        }
        sender.layer.borderColor = UIColor.clear.cgColor
        sender.layer.borderWidth = 1
    }
    
    @IBAction func changePhoneButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        self.verifyAndNavigate()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func verifyAndNavigate() {
        if let code = codeVerify() {
            if email != nil {
                serverRequest(code, type: .email)
            } else {
                serverRequest(code, type: .phone)
            }
        }else {
            showCodeError()
        }
    }
    
    private func showCodeError(_ message: String? = nil) {
//        PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "incorrectCodeTitle".localized, message: message ?? "incorrectCodeMessage".localized, buttonTitle: "incorrectCodeButtonTitle".localized))
    }
    
    private func serverRequest(_ code: String, type: VerificationType) {
        UIUtils.showLoading()
        CustomWebServiceRequest.approveCode(code: code, type: type, success: {
            switch type {
            case .email:
                CoreDataHelper.saveEmail(email: self.email!)
                UIUtils.navigateToMessage(self, messageType: .emailSuccessfull)
            case .phone:
                CoreDataHelper.savePhone(phone: self.phoneNumber!)
                UIUtils.navigateToMessage(self, messageType: .phoneNumberSuccessfull)
            }
            UIUtils.stopLoading()
        }) { (error) in
            UIUtils.stopLoading()
            self.showCodeError(error)
        }
        
        
    }

    private func codeVerify() -> String? {
        var code = ""
        guard let firstText = firstNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstText.isEmpty else {
            return nil
        }
        code += firstText
        guard let secondText = secondNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !secondText.isEmpty else {
            return nil
        }
        code += secondText
        guard let thirdText = thirdNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !thirdText.isEmpty else {
            return nil
        }
        code += thirdText
        guard let fourthText = fourthNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !fourthText.isEmpty else {
            return nil
        }
        code += fourthText

        return code
    }
    
}

extension VerificationVC: PinTexFieldDelegate {
    
    func didPressBackspace(_ textField: PinTextField) {
        self.textFieldDidChange(textField)
    }
    
}

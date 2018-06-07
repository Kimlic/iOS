//
//  PasscodeVC.swift
//  kimlic
//
//  Created by izzet öztürk on 6.12.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit
import SmileLock

class PasscodeVC: UIViewController {
    
    @IBOutlet weak var stackViewLbl: UIStackView!
    @IBOutlet weak var lblVerificationCode: UILabel!
    
    //MARK: Property
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 4
    
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
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }    
}
extension PasscodeVC: PasswordInputCompleteProtocol {
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {}
    
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        
    }
}

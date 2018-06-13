//
//  UserEmailVC.swift
//  kimlic
//
//  Created by paltimoz on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class UserEmailVC: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, email.isEmail {
            UIUtils.navigateToVerification(self, email: email)
        }else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "Wrong", message: "Wrong Email Address", buttonTitle: "Try! AGAIN"))
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

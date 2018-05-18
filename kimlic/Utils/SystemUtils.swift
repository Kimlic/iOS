//
//  SystemGeneralFunctions.swift
//  kimlic
//
//  Created by İzzet Öztürk on 18.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class SystemUtils {
    
    static func isValidEmail(email: String?) -> Bool {
        if let mail = email?.trimmingCharacters(in: .whitespaces) {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: mail)
        }
        return false
        
    }
    
    static func getFirstNameAndLastName() -> String! {
        let firstName = Defaults[.firstName] ?? ""
        let lastName = Defaults[.lastName] ?? ""
        return  firstName + " " + lastName
    }
    
    static func getCountryCodeAndPhoneNumber() -> String! {
        var countryCode = ""
        if Defaults[.phoneCountryCode] != nil {
            countryCode = "+\(Defaults[.phoneCountryCode]!)"
        }
        let fullPhone = countryCode + " " + (Defaults[.phone] ?? "")
        return fullPhone
    }
    
    //Acces_token does not reset after user logs out
    static func logout(controller: UIViewController!) {
        Defaults[.firstName] = nil
        Defaults[.lastName] = nil
        Defaults[.email] = nil
        Defaults[.emailId] = nil
        Defaults[.phone] = nil
        Defaults[.phoneCountryCode] = nil
        Defaults[.phoneId] = nil
        Defaults[.photoUrl] = nil
        Defaults[.photo] = nil
        Defaults[.emailVerified] = nil
        Defaults[.phoneVerified] = nil
        Defaults[.photoVerified] = nil
        Defaults[.userToken] = nil
        Defaults[.verificationCodeEnable] = nil
        Defaults[.verificationCode] = nil
        Defaults.synchronize()
        let root = UIUtils().setTutorialScreenAsRoot()
        controller.navigationController?.popRootViewControllerWithHandler(completion: {
            let popup = Popup()
            popup.title = "Success logout"
            popup.message = "You have successfully logged out!"
            popup.buttonTitle = "OK, Thanks"
            PopupGenerator.createPopup(controller: root, type: .success, popup: popup)
        })
    }   
    
}

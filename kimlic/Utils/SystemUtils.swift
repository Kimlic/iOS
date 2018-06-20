//
//  SystemGeneralFunctions.swift
//  kimlic
//
//  Created by İzzet Öztürk on 18.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit
import SwiftyUserDefaults

public class SystemUtils {
    
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
        Defaults[.passcode] = nil
        Defaults.synchronize()
//        let root = UIUtils.setTutorialScreenAsRoot()
        let root = UIUtils.setTutorialScreenAsRoot()
        controller.navigationController?.popRootViewControllerWithHandler(completion: {
            let popup = Popup()
            popup.title = "Success logout"
            popup.message = "You have successfully logged out!"
            popup.buttonTitle = "OK, Thanks"
            PopupGenerator.createPopup(controller: root, type: .success, popup: popup)
        })
    }
    
    static func drawCircleShapes(rootView: UIView, count: Int, incSize: Int) -> UIView {
        let startSize = rootView.frame.size.width
        rootView.layer.cornerRadius = CGFloat(startSize/2)
        for index in 1...count {
            let childSize = startSize + CGFloat(incSize * index)
                let childView = UIView(frame: CGRect(x: rootView.frame.origin.x - CGFloat(incSize), y: rootView.frame.origin.y - CGFloat(incSize), width: childSize, height: childSize))
                childView.layer.cornerRadius = CGFloat(childSize/2)
                childView.backgroundColor = rootView.backgroundColor
                childView.alpha = rootView.alpha - ((rootView.alpha * CGFloat(index)) / 10)
                rootView.addSubview(childView)
        }        
        return rootView
    }
    
}

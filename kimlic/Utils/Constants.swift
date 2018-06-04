//
//  Constants.swift
//  kimlic
//
//  Created by İzzet Öztürk on 14.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit


class Constants {
    struct Colors {
        
        static let appBlue = UIColor(hex:"#65beff")
        static let appGreen = UIColor(hex: "#9ABC2A")
        static let appOrange = UIColor(hex: "#FFB100")
        static let textGray = UIColor(hex:"#878787")
        
        static let popupTitleDarkGrey = UIColor(hex:"#626262")
        static let popupMsgGrey = UIColor(hex:"#ADADAD")
        static let popupErrorRed = UIColor(hex:"#e85234")
        static let popupWarningOrange = UIColor(hex:"#ffb40b")
        static let popupSuccessGreen = UIColor(hex:"#b3d641")
    }
    
    struct WebServicesUrl {
        private static let Base = Bundle.main.serverURL
        static  let ClientCredentials = Base + "/oauth/token"
        static let CreateUser = Base + "/v1/users"
        static let GetUserInfo = Base + "/v1/users/me"
        static let UpdateUser = Base + "/v1/users/me/profiles"
        static let BaseEmails = Base + "/v1/emails"
        static let BasePhone = Base + "/v1/phones"
        static let Authenticate = Base + "/v1/authentication_requests"
        static let Applications = Base + "/v1/applications"
        static let AllPermissions = Base + "/v1/access_grants"
    }
    
    struct PermissionScope {
        static let Profile = "profile"
        static let Emails = "emails"
        static let Phones = "phones"
    }
    
    struct Message {
        static let congratulation = "congratulation".localized
        static let idSecured = "congratulation".localized
        static let successPhoneNumber = "successPhoneNumber".localized
        static let successMnemonic = "successMnemonic".localized
        static let successPasscode = "successPasscode".localized
        static let successTouchID = "successTouchID".localized
    }
}

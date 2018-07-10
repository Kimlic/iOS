//
//  Constants.swift
//  kimlic
//
//  Created by İzzet Öztürk on 14.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit


class Constants {
    struct Environment {
        static let debug = false
    }
    
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
    
    struct StaticMessage {
        static let addressSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "congratulation".localized, desc: "successAddress".localized)
        static let passphraseSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "identitySecured".localized, desc: "successPassphrase".localized)
        static let passMatchSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "congratulation".localized, desc: "successPassMatch".localized)
        static let pascodeSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "identitySecured".localized, desc: "successPasscode".localized)
        static let touchIDSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "touchIDEnabled".localized, desc: "successTouchID".localized)
        static let verifyIDSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "congratulation".localized, desc: "successVerified".localized)
        static let phoneNumberSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "congratulation".localized, desc: "successPhoneNumber".localized)
        static let emailSuccessfull = Message(icon:  #imageLiteral(resourceName: "phone_success_icon"), title: "congratulation".localized, desc: "successEmail".localized)
        static let accountLinkSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "newAccount".localized, desc: "successAccount".localized)
        static let fullNameSuccessfull = Message(icon: #imageLiteral(resourceName: "phone_success_icon"), title: "congratulation".localized, desc: "successFullname".localized)
    }
    
    struct Contracts {
        let BaseURL: String
        let BaseHTTP: String
        let BasePort: Int
        let BasePath: String
        let AccountStorageAdapterAddress: String
        
        init() {
            BaseHTTP = "http"
            BaseURL = "40.115.43.126"
            BasePort = 22000
            BasePath = ""
            
            AccountStorageAdapterAddress = "0xd37debc7b53d678788661c74c94f265b62a412ac"
            
//            if(Constants.Environment.debug){
//                BaseHTTP = "http"
//                BaseURL = "127.0.0.1"
//                BasePort = 22000
//                BasePath = "/api/proxy"
//
//                AccountStorageAdapterAddress = "0xd63a61238cfc86db6dbb4ab4484f33b3d56b249c"
//            }else{
//                BaseHTTP = "http"
//                BaseURL = "mobile-api-dev.kimlic.com"
//                BasePort = 80
//                BasePath = "/api/quorum"
//
//                AccountStorageAdapterAddress = "0xd37debc7b53d678788661c74c94f265b62a412ac"
//            }
        }
    }
}

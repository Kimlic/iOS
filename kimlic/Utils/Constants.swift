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
    
    enum APIEndpoint: String {
        case config = "/api/config"
        case phoneVerification = "/api/verifications/phone"
        case phoneVerificationApprove =  "/api/verifications/phone/approve"
        case emailVerification = "/api/verifications/email"
        case emailVerificationApprove =  "/api/verifications/email/approve"
        
        func url() -> String {
            return Bundle.main.serverURL + rawValue
        }
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
    
    struct QuorumConfig {
        let scheme = "https"
        let host = "mobile-api-dev.kimlic.com"
        let port = 443
        let path = "/api/quorum"
        let networkId = 61059
    }
}

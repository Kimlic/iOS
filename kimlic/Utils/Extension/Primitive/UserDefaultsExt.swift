//
//  UserDefaultsExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 18.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import SwiftyUserDefaults


extension DefaultsKeys {
    static let firstName = DefaultsKey<String?>("firstName")
    static let lastName = DefaultsKey<String?>("lastName")
    static let email = DefaultsKey<String?>("email")
    static let emailId = DefaultsKey<String?>("emailId")
    static let phone = DefaultsKey<String?>("phone")
    static let phoneCountryCode = DefaultsKey<Int?>("phoneCountryCode")
    static let phoneId = DefaultsKey<String?>("phoneId")
    static let photoUrl = DefaultsKey<String?>("photoUrl")
    static let photo = DefaultsKey<Data?>("photo")
    static let emailVerified = DefaultsKey<Bool?>("emailVerified")
    static let phoneVerified = DefaultsKey<Bool?>("phoneVerified")
    static let photoVerified = DefaultsKey<Bool?>("photoVerified")
    static let userToken = DefaultsKey<String?>("userToken")
    static let accessToken = DefaultsKey<String?>("accessToken")
    
    //if the user wishes to generate a confirmation code for entry permits
    static let passcode = DefaultsKey<String?>("passcode")
    static let recovery = DefaultsKey<String?>("recovery")
    
    
    static let deviceId = DefaultsKey<String?>("deviceId")
}

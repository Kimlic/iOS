//
//  Enums.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit

enum PopupType {
    case error
    case warning
    case success
    case qrcode
}

enum TouchIDNavigateTarget {
    case UserProfileVC
    case UserBasicProfileVC
}

enum TermsNavigateTarget {
    case none, phoneNumber, accountRecovery
}

enum LevelBarAnimationType {
    case create
    case show
}

enum PasscodePageType {
    case confirm
    case create
    case createConfirm
    case update
    case delete
}

enum AppStoryboard : String {
    // Must be the same as storyboard name
    case SplashScreen, SignUp, Tutorial, TermsAndConditions, PhoneNumber, Verification, Message, TouchID, Passcode,
    MnemonicImport, MnemonicCreate, VerifyPassphrase, Settings, UserEmail, Profile, UserInfo
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

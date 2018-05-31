//
//  Enums.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation


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

enum LevelBarAnimationType {
    case create
    case show
}

enum VerificationCodePageType {
    case create
    case createConfirm
    case verificate
}

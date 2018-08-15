//
//  VerifyIDModel.swift
//  kimlic
//
//  Created by izzet öztürk on 14.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

struct VerifyIDModel {
    var firstName: String = ""
    var lastName: String = ""
    var country: String = "TR"
    var lang: String = "en"
    var timestamp: Int64 = Date().toMillis()
    var contractAddress: String = ""
    var accountAddress: String = ""
    var documentType: DocumentType = .driversLicense
    var faceImage: UIImage?
    var documentFrontImage: UIImage?
    var documentBackImage: UIImage?
    var deviceOs: String = "ios"
    var deviceToken: String = ""
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = CoreDataHelper.getUser()
        
        self.firstName = user?.firstName ?? self.firstName
        self.lastName = user?.lastName ?? self.lastName
        self.accountAddress = appDelegate.quorumManager?.accountAddress.lowercased() ?? self.accountAddress
        self.contractAddress = appDelegate.quorumAPI?.addresses.contextContract.lowercased() ?? self.contractAddress
        self.deviceToken = user?.deviceToken ?? self.deviceToken
        self.lang = Locale.current.languageCode ?? self.lang
    }
    
    init(country: String, timestamp: Int64, documentType: DocumentType, faceImage: UIImage?, documentFrontImage: UIImage?, documentBackImage: UIImage?) {
        self.init()
        self.country = country
        self.timestamp = timestamp
        self.documentType = documentType
        self.faceImage = faceImage
        self.documentFrontImage = documentFrontImage
        self.documentBackImage = documentBackImage
    }
}

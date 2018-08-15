//
//  VerifyIDModel.swift
//  kimlic
//
//  Created by izzet öztürk on 14.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

struct VerifyIDModel {
    var firstName: String?
    var lastName: String?
    var country: String = "TR"
    var lang: String = "en"
    var timestamp: Int64 = Date().toMillis()
    var contractAddress: String?
    var accountAddress: String?
    var documentType: DocumentType = .driversLicense
    var faceImage: UIImage?
    var documentFrontImage: UIImage?
    var documentBackImage: UIImage?
    var deviceOs: String = "ios"
    var deviceToken: String?
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = CoreDataHelper.getUser()
        
        self.firstName = user?.firstName
        self.lastName = user?.lastName
        self.accountAddress = appDelegate.quorumManager?.accountAddress.lowercased()
        self.contractAddress = appDelegate.quorumAPI?.addresses.contextContract.lowercased()
        self.deviceToken = user?.deviceToken
    }
}

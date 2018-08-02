//
//  ICloudDataHelper.swift
//  kimlic
//
//  Created by İzzet Öztürk on 2.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation
import CloudKit

final class ICloudDataHelper {
    
    private let database = CKContainer.default().privateCloudDatabase
    private let recordType = KimlicUser.className
    
    static func saveOrUpdate() {
    }
    
}

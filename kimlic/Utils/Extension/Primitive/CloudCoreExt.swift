//
//  CloudCoreExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 3.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import CloudCore
import CloudKit

extension CloudCore {
    
    // TODO: To be edited later
    static func deleteIdentity(completion: (() -> ())? = nil, failure: ((String?) -> ())? = nil) {
        
        // Before deleted Core Data
        CoreDataHelper.destroy()
        
        // After deleted ICloud
        config.container.privateCloudDatabase.delete(withRecordZoneID: config.zoneID) { (deletedID, error) in
            if error != nil {
                failure?(error?.localizedDescription)
            }
        }
        completion?()
    }
}

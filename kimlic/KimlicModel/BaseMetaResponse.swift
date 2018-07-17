//
//  MetaResponse.swift
//  kimlic
//
//  Created by ibrahim özdemir on 14.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseMetaResponse: Mappable {
    var code: Int?
    var request_id: String?
    var type: String?
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        code    <- map["code"]
        request_id         <- map["request_id"]
        type      <- map["type"]
        url       <- map["url"]
    }
}

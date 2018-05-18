//
//  GenericResponseMappable.swift
//  kimlic
//
//  Created by İzzet Öztürk on 24.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol GenericResponseMappable: Mappable {
    
    func dictionaryRepresentation() -> [String: Any]
    
}

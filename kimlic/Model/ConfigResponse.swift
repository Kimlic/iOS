//
//  ConfigResponse.swift
//  kimlic
//
//  Created by Dmytro Nasyrov on 7/18/18.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation
import ObjectMapper

final class ConfigResponse: GenericResponseMappable {

    // MARK: - Types
    
    private struct SerializationKeys {
        static let contextContract = "context_contract"
    }
    
    init?(map: Map) {}
    
    // MARK: - Variables
    
    var contextContract: String?

    // MARK: - Public
    
    func mapping(map: Map) {
        contextContract <- map[SerializationKeys.contextContract]
    }
    
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        guard let contextContract = contextContract else { return [:] }
        dictionary[SerializationKeys.contextContract] = contextContract

        return dictionary
    }
}

//extension ConfigResponse: NSCoding {
//    
//    convenience init(coder aDecoder: NSCoder) {
//        contextContract = aDecoder.decodeObject(forKey: SerializationKeys.contextContract) as? String
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(contextContract, forKey: SerializationKeys.contextContract)
//    }
//}

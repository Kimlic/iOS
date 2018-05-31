//
//  PhoneResponse.swift
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper

public class PhoneResponse: GenericResponseMappable, NSCoding {
    
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let value = "value"
        static let countryCode = "country_code"
        static let verified = "verified"
        static let verifiedAt = "verified_at"
        static let createdAt = "created_at"
        static let updatedAt = "updated_at"
    }
    
    var value: String?
    var countryCode: Int?
    var verified: Bool?
    var verifiedAt: String?
    var createdAt: String?
    var updatedAt: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        value <- map[SerializationKeys.value]
        countryCode <- map[SerializationKeys.countryCode]
        verified <- map[SerializationKeys.verified]
        verifiedAt <- map[SerializationKeys.verifiedAt]
        createdAt <- map[SerializationKeys.createdAt]
        updatedAt <- map[SerializationKeys.updatedAt]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = value { dictionary[SerializationKeys.value] = value }
        if let value = countryCode { dictionary[SerializationKeys.countryCode] = value }
        if let value = verified { dictionary[SerializationKeys.verified] = value }
        if let value = verifiedAt { dictionary[SerializationKeys.verifiedAt] = value }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? String
        self.countryCode = aDecoder.decodeObject(forKey: SerializationKeys.countryCode) as? Int
        self.verified = aDecoder.decodeObject(forKey: SerializationKeys.verified) as? Bool
        self.verifiedAt = aDecoder.decodeObject(forKey: SerializationKeys.verifiedAt) as? String
        self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
        self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(value, forKey: SerializationKeys.value)
        aCoder.encode(countryCode, forKey: SerializationKeys.countryCode)
        aCoder.encode(verified, forKey: SerializationKeys.verified)
        aCoder.encode(verifiedAt, forKey: SerializationKeys.verifiedAt)
        aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
        aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    }
    
}


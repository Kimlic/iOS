//
//  EmailResponse.swift
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper

public class EmailResponse: GenericResponseMappable, NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let value = "value"
        static let verified = "verified"
        static let verifiedAt = "verified_at"
    }
    
    var value: String?
    var verified: Bool?
    var verifiedAt: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){}
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        value <- map[SerializationKeys.value]
        verified <- map[SerializationKeys.verified]
        verifiedAt <- map[SerializationKeys.verifiedAt]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = value { dictionary[SerializationKeys.value] = value }
        if let value = verified { dictionary[SerializationKeys.verified] = value }
        if let value = verifiedAt { dictionary[SerializationKeys.verifiedAt] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? String
        self.verified = aDecoder.decodeObject(forKey: SerializationKeys.verified) as? Bool
        self.verifiedAt = aDecoder.decodeObject(forKey: SerializationKeys.verifiedAt) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(value, forKey: SerializationKeys.value)
        aCoder.encode(verified, forKey: SerializationKeys.verified)
        aCoder.encode(verifiedAt, forKey: SerializationKeys.verifiedAt)
    }    
}

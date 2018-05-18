//
//  UserResponse.swift
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse: GenericResponseMappable, NSCoding {
    
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let avatarUrl = "avatar_url"
    }
    
    var firstName: String?
    var lastName: String?
    var avatarUrl: String?
    
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
        firstName <- map[SerializationKeys.firstName]
        lastName <- map[SerializationKeys.lastName]
        avatarUrl <- map[SerializationKeys.avatarUrl]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = firstName { dictionary[SerializationKeys.firstName] = value }
        if let value = lastName { dictionary[SerializationKeys.lastName] = value }
        if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
        self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
        self.avatarUrl = aDecoder.decodeObject(forKey: SerializationKeys.avatarUrl) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: SerializationKeys.firstName)
        aCoder.encode(lastName, forKey: SerializationKeys.lastName)
        aCoder.encode(avatarUrl, forKey: SerializationKeys.avatarUrl)
    }
    
}


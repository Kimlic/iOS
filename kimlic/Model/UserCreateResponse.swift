//
//  UserCreateResponse.swift
//  UserCreateResponse
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper

public class UserCreateResponse: GenericResponseMappable, NSCoding {
    
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let walletAddress = "wallet_address"
        static let privateKey = "private_key"
        static let createdAt = "created_at"
        static let updatedAt = "updated_at"
    }
    
    var walletAddress: String?
    var privateKey: String?
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
        walletAddress <- map[SerializationKeys.walletAddress]
        privateKey <- map[SerializationKeys.privateKey]
        createdAt <- map[SerializationKeys.createdAt]
        updatedAt <- map[SerializationKeys.updatedAt]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = walletAddress { dictionary[SerializationKeys.walletAddress] = value }
        if let value = privateKey { dictionary[SerializationKeys.privateKey] = value }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.walletAddress = aDecoder.decodeObject(forKey: SerializationKeys.walletAddress) as? String
        self.privateKey = aDecoder.decodeObject(forKey: SerializationKeys.privateKey) as? String
        self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
        self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(walletAddress, forKey: SerializationKeys.walletAddress)
        aCoder.encode(privateKey, forKey: SerializationKeys.privateKey)
        aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
        aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    }
    
}


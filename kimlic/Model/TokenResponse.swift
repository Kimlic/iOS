//
//  TokenResponse
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper

public class TokenResponse: GenericResponseMappable, NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let accessToken = "access_token"
        static let tokenType = "token_type"
        static let scope = "scope"
        static let createdAt = "created_at"
    }
    
    var accessToken: String?
    var tokenType: String?
    var scope: String?
    var createdAt: Int?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){}
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        accessToken <- map[SerializationKeys.accessToken]
        tokenType <- map[SerializationKeys.tokenType]
        scope <- map[SerializationKeys.scope]
        createdAt <- map[SerializationKeys.createdAt]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = accessToken { dictionary[SerializationKeys.accessToken] = value }
        if let value = tokenType { dictionary[SerializationKeys.tokenType] = value }
        if let value = scope { dictionary[SerializationKeys.scope] = value }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.accessToken = aDecoder.decodeObject(forKey: SerializationKeys.accessToken) as? String
        self.tokenType = aDecoder.decodeObject(forKey: SerializationKeys.tokenType) as? String
        self.scope = aDecoder.decodeObject(forKey: SerializationKeys.scope) as? String
        self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: SerializationKeys.accessToken)
        aCoder.encode(tokenType, forKey: SerializationKeys.tokenType)
        aCoder.encode(scope, forKey: SerializationKeys.scope)
        aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    }    
}

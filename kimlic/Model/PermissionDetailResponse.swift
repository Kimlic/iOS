//
//  PermissionDetailResponse.swift
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper

public class PermissionDetailResponse: GenericResponseMappable, NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let scopes = "scopes"
        static let avatarUrl = "avatar_url"
        static let theme = "theme"
    }
    
    var name: String?
    var scopes: [String]?
    var avatarUrl: String?
    var theme: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){}
    
    init(name: String?, scope: [String]?, avatarUrl: String?, theme: String?) {
        self.name = name
        self.scopes = scope
        self.avatarUrl = avatarUrl
        self.theme = theme
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        name <- map[SerializationKeys.name]
        scopes <- map[SerializationKeys.scopes]
        avatarUrl <- map[SerializationKeys.avatarUrl]
        theme <- map[SerializationKeys.theme]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = scopes { dictionary[SerializationKeys.scopes] =  value}
        if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
        if let value = theme { dictionary[SerializationKeys.theme] = value }
        return dictionary
    }    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.scopes = aDecoder.decodeObject(forKey: SerializationKeys.scopes) as? [String]
        self.avatarUrl = aDecoder.decodeObject(forKey: SerializationKeys.avatarUrl) as? String
        self.theme = aDecoder.decodeObject(forKey: SerializationKeys.theme) as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(scopes, forKey: SerializationKeys.scopes)
        aCoder.encode(avatarUrl, forKey: SerializationKeys.avatarUrl)
        aCoder.encode(theme, forKey: SerializationKeys.theme)
    }
}

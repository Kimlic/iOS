//
//  WrappedResponseCollection.swift
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: Declaration for string constants to be used to decode and also serialize.
private struct SerializationKeys {
    static let id = "id"
    static let type = "type"
    static let attributes = "attributes"
}


public final class WrappedResponseCollection<T: GenericResponseMappable>: Mappable {
    
    
    // MARK: Properties
    public var id: String?
    public var type: String?
    public var attributes: [T]?
    
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
        id <- map[SerializationKeys.id]
        type <- map[SerializationKeys.type]
        attributes <- map[SerializationKeys.attributes]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = attributes {
            var dictionaries = [[String: Any]]()
            for item in value {
                dictionaries.append(item.dictionaryRepresentation())
            }
            dictionary[SerializationKeys.attributes] = dictionaries
        }
        return dictionary
    }
    
}


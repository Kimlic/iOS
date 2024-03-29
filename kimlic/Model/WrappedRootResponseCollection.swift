//
//  WrappedRootResponseCollection
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: Declaration for string constants to be used to decode and also serialize.
private struct SerializationKeys {
    static let data = "data"
    static let included = "included"
}


public final class WrappedRootResponseCollection<T: GenericResponseMappable>: Mappable {
    
    
    // MARK: Properties
    public var data: [WrappedResponse<T>]?
    public var included: [WrappedResponse<T>]?
    
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
        data <- map[SerializationKeys.data]
        included <- map[SerializationKeys.included]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = data {
            var dictionaries = [[String: Any]]()
            for item in value {
                dictionaries.append(item.dictionaryRepresentation())
            }
            dictionary[SerializationKeys.data] = dictionaries
        }
        if let value = included {
            var dictionaries = [[String: Any]]()
            for item in value {
                dictionaries.append(item.dictionaryRepresentation())
            }
            dictionary[SerializationKeys.included] = dictionaries
        }
        return dictionary
    }
    
}



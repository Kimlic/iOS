//
//  NSObjectExt.swift
//  kimlic
//
//  Created by ibrahim özdemir on 18.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation

public extension NSObject {
    
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return stringFromClass(aClass: self)
    }
    
}

public func stringFromClass(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
